//
//  ViewControllerPresenting.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

/**
 A protocol that mimics the view controller presentation APIs of `UIViewController`. Can be implemented by coordinators.
 */
public protocol ViewControllerPresenting {

    /**
     Presents a view controller in a primary context.
     
     - Parameter viewController: The view controller to show.
     - Parameter sender: The object that initiated the request.
     */
    func show(_ viewController: UIViewController, sender: Any?)

    /**
     Presents a view controller in a secondary context.
     
     - Parameter viewController: The view controller to show.
     - Parameter sender: The object that initiated the request.
     */
    func showDetailViewController(_ viewController: UIViewController, sender: Any?)

    /**
     Presents a view controller modally.
     
     - Parameter viewControllerToPresent: The view controller to be presented modallay.
     - Parameter flag: Pass `true` to animate the presentation; otherwise pass `false`.
     - Parameter completion: The block to execute after the presentation has completed. Optional.
     */
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)

    /**
     Dismisses the view controller that was presented modally.
     
     - Parameter flag: Pass `true` to animate the dismissal; otherwise pass `false`.
     - Parameter completion: The block to execute after the dismissal has completed. Optional.
     */
    func dismiss(animated flag: Bool, completion: (() -> Void)?)

}
