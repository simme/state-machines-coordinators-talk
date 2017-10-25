//
//  TabBarCoordinator.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

/**
 The tab bar coordinator manages a group of coordinators that own a tab each in a `UITabBarController`.
 */
open class TabBarCoordinator: Coordinator<UITabBarController>, UITabBarControllerDelegate {

    /// A list of child coordinator identifiers
    open var coordinatorIdentifiersForTabBarItems: [String] = [] {
        didSet {
            updateTabBar()
        }
    }

    // MARK: Initializing

    public init() {
        super.init(rootViewController: UITabBarController())
    }

    // MARK: Coordinating

    open override func start(with callback: @escaping () -> Void) {
        rootViewController.delegate = self
        super.start(with: callback)
        updateTabBar()
    }

    // MARK: Tab Bar Management

    /// Update the tabbar to match the current array of coordinators.
    private func updateTabBar() {
        let viewControllers = coordinatorIdentifiersForTabBarItems.map {
            return (self.childCoordinators[$0] as? Coordinator<UINavigationController>)?.rootViewController
        }.flatMap { $0 }

        rootViewController.setViewControllers(viewControllers, animated: false)
    }
    
    /**
     Finds the string identifier corresponding to the given tab index.
     
     - Parameter intex: The index of the tab to find the coordinator idenfier for.
     
     - Returns: The string identifier for the given index. Will crash on out of bounds indices.
     */
    private func identifier(for index: Int) -> String {
        return coordinatorIdentifiersForTabBarItems[index]
    }
    
    /**
     - Returns: The currently active coordinator, if any.
     */
    private func currentlyActiveCoordinator() -> Coordinating? {
        return childCoordinators.filter { $0.value.isActive }.first?.value
    }
    
    /**
     Activates the coordinator for the tab with the given index.
     
     - Parameter index: The index of the tab to activate.
     */
    private func activate(coordinatorAt index: Int) {
        currentlyActiveCoordinator()?.isActive = false
        childCoordinators[identifier(for: index)]?.isActive = true
    }

    // MARK: UITabBarControllerDelegate

    /**
     Respond to changes in the tab bar selection.
     */
    open func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        activate(coordinatorAt: tabBarController.selectedIndex)
    }

}
