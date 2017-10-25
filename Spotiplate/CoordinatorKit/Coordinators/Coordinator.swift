//
//  Coordinator.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

open class Coordinator<VC: UIViewController>: NSObject, Coordinating {

    // MARK: Properties

    /// The root view controller that this coordinator operates from.
    open let rootViewController: VC

    /// A string identifying this coordinator.
    open lazy var identifier: String = {
        return String(describing: type(of: self))
    }()

    /// The coordinator that is responsible for this coordinator.
    public var parent: Coordinating?

    /// A boolean value representing the current "active" state of the coordinator.
    open var isActive: Bool = false

    /**
     A dictionary of coordinators started bu this coordinator.

     This dictionary should not be modified directly. To add or remove child coordinators you should use the
     `startChild` and `stopChild` methods.
     */
    fileprivate(set) public var childCoordinators: [String: Coordinating] = [:]

    // MARK: Initialization

    /**
     Initialize a new coordinator that operators from the given root view controller.

     - Parameter rootViewController: A `UIViewController` subclass that the new view controller uses as a base for it's
         flow.

     - Returns: A coordinator instance.
     */
    public init(rootViewController: VC?) {
        guard let rootViewController = rootViewController else {
            fatalError("A coordinator must be initialized with a UIViewController subclass. Or override this initializer and provide own there.")
        }
        self.rootViewController = rootViewController
        super.init()
    }

    // MARK: Starting and Stopping

    /**
     Start the coordinator, making it create or display it's initial view controller.

     - Parameter callback: An optional closure called once the coordinator has started.
     */
    open func start(with callback: @escaping () -> Void = {}) {
        callback()
    }

    /**
     Stop the coordinator, making it clean up the view controllers it is responsible for.

     - Parameter callback: An optional closure called once the coordinator has stopped.
     */
    open func stop(with callback: @escaping () -> Void = {}) {
        callback()
    }

    // MARK: Managing Child View Controllers

    /**
     Starts the given coordinator and add it to the dictionary of children.

     - Parameter coordinator: The coordinator to start.
     - Parameter callback: An optional callback called when the child coordinator has started.
     */
    public func startChild(coordinator: Coordinating, callback: @escaping () -> Void = {}) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parent = self
        coordinator.start(with: callback)
    }

    /**
     Stops a given coordinator and removes it from the dictionary of children.

     - Parameter coordinator: The coordinator to stop.
     - Parameter callback: An optional callback called when the child coordinator stops.
     */
    public func stopChild(coordinator: Coordinating, callback: @escaping () -> Void = {}) {
        coordinator.parent = nil
        coordinator.stop { [weak self] in
            self?.childCoordinators.removeValue(forKey: coordinator.identifier)
            callback()
        }
    }

    /**
     Notifies the coordinator that another (that it manages) coordinator completed its tasks and is ready to stop.

     - Parameter coordinator: The coordinator that is ready to stop.
     */
    public func coordinatorDidFinish(_ coordinator: Coordinating) {
        stopChild(coordinator: coordinator)
    }

}
