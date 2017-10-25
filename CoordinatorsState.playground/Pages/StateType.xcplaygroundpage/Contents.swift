//: [Previous](@previous)

import Foundation

protocol StateType {
    associatedtype InputEvent
    associatedtype OutputCommand

    mutating func handle(_ event: InputEvent) -> OutputCommand

    static var initialState: Self { get }
}
