//
//  ApplicationCoordinator.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-06.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit
import CoordinatorKit
import Spotiface

final class ApplicationCoordinator: TabBarCoordinator, ContextHolding {

    var context: ApplicationContext? {
        didSet {
            passContextToChildren()
        }
    }

    override init() {
        super.init()
    }

    override func start(with callback: @escaping () -> Void) {
        coordinatorIdentifiersForTabBarItems = [
            spottingsCoordinator.identifier,
            settingsCoordinator.identifier
        ]
        super.start(with: callback)
        rootViewController.selectedIndex = currentState.tabIndex
    }

    // MARK: Child Coordinators

    private lazy var spottingsCoordinator: SpottingsCoordinator = {
        let coordinator = SpottingsCoordinator()
        coordinator.context = self.context
        self.startChild(coordinator: coordinator)
        return coordinator
    }()

    private lazy var settingsCoordinator: SettingsCoordinator = {
        let coordinator = SettingsCoordinator()
        coordinator.context = self.context
        self.startChild(coordinator: coordinator)
        return coordinator
    }()

    // MARK: Tab Bar Delegate

    override func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        let event = ApplicationCoordinatorState.Event(tabIndex: tabBarController.selectedIndex)
        respond(to: currentState.handle(event))
    }

    // MARK: Managing the State

    /// The coordinator's current state.
    fileprivate var currentState: ApplicationCoordinatorState = .initialState
    
    fileprivate func respond(to command: ApplicationCoordinatorState.Command) {
        switch command {
        case .showSpottings:
            rootViewController.selectedIndex = currentState.tabIndex
            settingsCoordinator.isActive = false
            spottingsCoordinator.isActive = true
        case .showSettings:
            rootViewController.selectedIndex = currentState.tabIndex
            settingsCoordinator.isActive = true
            spottingsCoordinator.isActive = false
        }
    }

    // MARK: State Restoration

    private var initialTabIndex = 0

    public required init?(coder aDecoder: NSCoder) {
        super.init()
        currentState = ApplicationCoordinatorState(tabIndex: aDecoder.decodeInteger(forKey: "selectedTab"))
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(currentState.tabIndex, forKey: "selectedTab")
        print("Encoded selected tab")
    }

}

extension ApplicationCoordinatorState {
    init(tabIndex: Int) {
        switch tabIndex {
        case 0: self = .spottings
        case 1: self = .settings
        default: fatalError("Invalid tab index")
        }
    }
    
    var tabIndex: Int {
        switch self {
        case .spottings: return 0
        case .settings: return 1
        }
    }
}

extension ApplicationCoordinatorState.Event {
    init(tabIndex: Int) {
        switch tabIndex {
        case 0: self = .tappedSpottingsTab
        case 1: self = .tappedSettingsTab
        default: fatalError("Invalid tab index")
        }
    }
}
