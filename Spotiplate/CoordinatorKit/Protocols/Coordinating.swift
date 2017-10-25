//
//  Coordinating.swift
//  CoordinatorKit
//
//  Created by Simon Ljungberg on 2017-10-14.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation

/**
 Implementors of the Coordinating protocol
 */
public protocol Coordinating: class {

    // MARK: Properties

    /**
     A unique identifier that identifies a specific coordinator.

     By default implemented as the String representation of a coordinator's subclass type. Directly instantiated
     coordinators may need to manually set this.
     */
    var identifier: String { get }

    /// A reference to the coordinator that started this coordinator.
    weak var parent: Coordinating? { get set }

    /// A list of child coordinators, keyed by identifier.
    var childCoordinators: [String: Coordinating] { get }

    /**
     A boolean value representing the current "active" state of the coordinator.

     If `false` the coordinator might consider pausing location monitoring or other non-essential tasks.
     */
    var isActive: Bool { get set }

    // MARK: Starting and Stopping

    /**
     Tells the coordinator to start.

     Starting a coordinator means that it should somehow present or display a view controller. Once the coordinator has
     completed it's starting it should call the callback.

     - Parameter callback: A closure that the implementing coordinator will call once the coordinator is started.
     */
    func start(with callback: @escaping () -> Void)

    /**
     Tells the coordinator to stop.

     When stopped the coordinator should rollback and dismiss any view controllers that is respoinsible for. It should
     also clean out any resources that it is holding on to.
     */
    func stop(with callback: @escaping () -> Void)

    /**
     Notifies the coordinator that another (that it manages) coordinator completed its tasks and is ready to stop.

     - Parameter coordinator: The coordinator that is ready to stop.
     */
    func coordinatorDidFinish(_ coordinator: Coordinating)
}
