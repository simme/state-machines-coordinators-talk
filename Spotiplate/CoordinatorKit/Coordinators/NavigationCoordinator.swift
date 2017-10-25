//
//  NavigationCoordinator.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

/**
 A coordinator subclass specifically tailored to handle a `UINavigationController` stack. It keeps track of view
 controllers that has been pushed on to the stack. And forgets them when they are popped. When the list of managed view
 controllers becomes empty it let's the parent coordinator know that its responsibilities have ended and control of the
 flow can be taken back by the parent.
 */
open class NavigationCoordinator: Coordinator<UINavigationController>, UINavigationControllerDelegate {

    // MARK: Properties

    /// A list of view controllers managed by this partuclar coordinator.
    open var viewControllers: [UIViewController] = []

    /// Keep a weak reference to any previous navigation controller delegate, so that we can hand control back to them.
    weak var previousNavigationDelegate: UINavigationControllerDelegate?

    public init() {
        super.init(rootViewController: UINavigationController())
    }

    // MARK: Coordinating

    /**
     Starts the coordinator which will set itself as the navigation controller delegate.

     A weak reference to the previous delegate is stored and restored to the navigation controller when stopped.

     - Parameter callback: An optional callback calledn when started.
     */
    open override func start(with callback: @escaping () -> Void = {}) {
        previousNavigationDelegate = rootViewController.delegate
        rootViewController.delegate = self
        super.start(with: callback)
    }

    /**
     Stops the coordinator and hands navigation controller delegacy back to the previous delegate.

     - Parameter callback: An optional callback called when stopped.
     */
    open override func stop(with callback: @escaping () -> Void = {}) {
        rootViewController.delegate = previousNavigationDelegate
        viewControllers.removeAll()
        super.stop(with: callback)
    }

    // MARK: View Controller Navigation

    /**
     Pushes the given view controller onto the stack and add a reference to it.

     - Parameter viewController: The view controller to push onto the navigation stack.
     - Parameter animated: A boolean value indicating whether the push should be animated.
     */
    public func push(_ viewController: UIViewController, animated: Bool = true) {
        viewControllers.append(viewController)
        rootViewController.pushViewController(viewController, animated: animated)
    }

    // MARK: UINavigationControllerDelegate

    /**
     Respond to a view controller being popped or pushed on the nav stack. If the event was a pop and the view
     controllers that we were responsible for have all left the nav stack, let our parent know that we're done.
     */
    public func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        // Get a reference to the view controller being transitioned _from_.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Pop the last view controller of the stack, if that's the view controller being popped off the nav stack.
        if let topViewController = viewControllers.last, topViewController === fromViewController {
            viewControllers.removeLast()
        }

        // If there are no view controllers left that we're responsible for, let our parent know.
        if viewControllers.isEmpty {
            parent?.coordinatorDidFinish(self)
        }
    }

}
