//: [Previous](@previous)

import Foundation

struct Item {

}

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
        case reloadTableView
        case showDetails(Item)
        case viewLocation(Item)
    }

    static var initialState: ItemCoordinatorState = .list([])

    mutating func handle(_ event: Event) -> Command {
        switch (self, event) {
        case (.empty, .loaded(let items)):
            self = .list(items)
            return .reloadTableView
        case (.list, .selected(let item)):
            self = .detail(item)
            return .showDetails(item)
        case (.detail(let item), .viewLocation):
            self = .location(item)
            return .viewLocation(item)
        default:
            fatalError("Invalid ")
        }
    }
}
