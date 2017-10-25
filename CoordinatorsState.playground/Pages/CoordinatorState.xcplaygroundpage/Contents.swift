//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit



/**
 Defines the state machine for the Coordinator
 */
enum ItemCoordinatorState: StateType {
    case empty
    case list([Item])
    case detail(Item)
    case location(Item)

    enum Event {
        case loaded([Item])
        case selected(Item)
        case viewLocation
    }

    enum Command {
        case updateList
        case showDetails(Item)
        case viewLocation(Item)
    }

    static var initialState: ItemCoordinatorState = .empty

    mutating func handle(_ event: Event) -> Command {
        switch (self, event) {
        case (.empty, .loaded(let items)):
            self = .list(items)
            return .updateList
        case (.list, .selected(let item)):
            self = .detail(item)
            return .showDetails(item)
        case (.detail(let item), .viewLocation):
            self = .location(item)
            return .viewLocation(item)
        default:
            fatalError("Invalid event: \(event) sent to current state: \(self).")
        }
    }
}


/**
 Our coordinator.
 */
final class Coordinator {

    lazy var navigationController: UINavigationController = {
        let nav = UINavigationController(rootViewController: self.viewController(for: self.currentState))
        nav.delegate = navigationManager
        return nav
    }()

    lazy var navigationManager: CoordinatorNavigationStateManager = CoordinatorNavigationStateManager(self, initialState: self.currentState)

    func viewController(for state: ItemCoordinatorState) -> UIViewController {
        switch state {
        case .empty:
            let controller = EmptyViewController()
            controller.delegate = self
            return controller
        case .list(let items):
            let controller = ItemsTableViewController(items: items)
            controller.delegate = self
            return controller
        case .detail(let item):
            let controller = ItemDetailViewController(item: item)
            controller.delegate = self
            return controller
        case .location(let item):
            let controller = MapController(item: item)
            return controller
        }
    }

    // MARK: Managing state

    fileprivate var currentState: ItemCoordinatorState = .initialState

    private func respond(to command: ItemCoordinatorState.Command) {
        switch command {
        case .updateList:
            navigationManager.states = [currentState]
            navigationController.setViewControllers([viewController(for: currentState)], animated: false)
        case .showDetails:
            navigationController.pushViewController(viewController(for: currentState), animated: true)
        case .viewLocation:
            navigationController.pushViewController(viewController(for: currentState), animated: true)
        }
    }

}

// Delegate extensions

extension Coordinator: EmptyViewControllerDelegate {
    func addStuff() {
        let items: [Item] = [
            Item(name: "Smultronställe", location: randomCoordinate()),
            Item(name: "Foo Cafe", location: randomCoordinate()),
            Item(name: "Stormwind Castle", location: randomCoordinate()),
            Item(name: "Orgrimmar", location: randomCoordinate()),
            Item(name: "Hyrule", location: randomCoordinate()),
            Item(name: "Mordor", location: randomCoordinate()),
        ]

        self.respond(to: currentState.handle(.loaded(items)))
    }

    private func randomCoordinate() -> Item.Coordinate {
        let lat = arc4random_uniform(90)
        let lon = arc4random_uniform(90)
        return (Double(lat), Double(lon))
    }
}

extension Coordinator: ItemsTableViewControllerDelegate {
    func didSelectItem(_ item: Item) {
        self.respond(to: currentState.handle(.selected(item)))
    }
}

extension Coordinator: ItemDetailViewControllerDelegate {
    func detailView(_ detailViewController: ItemDetailViewController, requestsLocationDisplayOf item: Item) {
        self.respond(to: currentState.handle(.viewLocation))
    }
}

// Hacky example of how one might manage state transitions when popping a navigation controller.

class CoordinatorNavigationStateManager: NSObject, UINavigationControllerDelegate {
    var states: [ItemCoordinatorState] = []
    weak var coordinator: Coordinator?

    init(_ coordinator: Coordinator, initialState: ItemCoordinatorState) {
        self.coordinator = coordinator
        states.append(initialState)
        super.init()
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // This is a pop operation
        if !navigationController.viewControllers.contains(fromViewController) {
            states.removeLast()
            coordinator?.currentState = states.last!
        }
        // This is a push
        else {
            states.append(coordinator!.currentState)
        }
    }
}


// Show it in the live view
let coordinator = Coordinator()
let (parent, _) = playgroundControllers(device: .phone4_7inch, orientation: .portrait, child: coordinator.navigationController)
PlaygroundPage.current.liveView = parent.view
