//
//  SpottingsCoordinator.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-10.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit
import CoordinatorKit
import Spotiface

final class SpottingsCoordinator: NavigationCoordinator, ContextHolding {

    var context: ApplicationContext? {
        didSet {
            passContextToChildren()
        }
    }

    override func start(with callback: @escaping () -> Void) {
        rootViewController.pushViewController(spottingsController, animated: false)
        rootViewController.tabBarItem.title = "Spottings"
        super.start(with: callback)
    }
    
    private lazy var spottingsController: SpottingsTableViewController = {
        let spottings = SpottingsTableViewController(spottings: [])
        return spottings
    }()
}
