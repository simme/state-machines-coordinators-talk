//
//  Coordinator+ViewControllerPresenting.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

/**
 Provides default implementations of the `ViewControllerPresenting` protocol for `UINavigationController`
 and `UITabBarController` coordinators.
 */

extension ViewControllerPresenting where Self: Coordinator<UINavigationController> {
    public func show(_ viewController: UIViewController, sender: Any?) {
        rootViewController.show(viewController, sender: sender)
    }

    public func showDetailViewController(_ viewController: UIViewController, sender: Any?) {
        rootViewController.showDetailViewController(viewController, sender: sender)
    }

    public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        rootViewController.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        rootViewController.dismiss(animated: flag, completion: completion)
    }
}
