//
//  StateType.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-06.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation

/**
 A type that represents a state machine.
 */
public protocol StateType {

    /// A type that represents an event that the state will react to.
    associatedtype InputType

    /// A type that the state generates as the respons to an `InputType`.
    associatedtype OutputType

    /// The initial value of the state machine.
    static var initialState: Self { get }

    /**
     Asks the state machine to respond to an event. As a response the state may change and/or generate an command.

     - Parameter event: The event to react to.

     - Returns: A command that the caller of the function should react to in turn.
     */
    mutating func handle(_ event: InputType) -> OutputType

}
