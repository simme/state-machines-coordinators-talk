//
//  ApplicationCoordinatorState.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import CoordinatorKit

/**
 Defines the various states that the application coordinator can be in.
 */
enum ApplicationCoordinatorState: StateType {

    /// Currently displaying the spottings tab.
    case spottings
    
    /// Currently displaying the settings tab.
    case settings

    static var initialState: ApplicationCoordinatorState = .spottings

    enum Event {
        case tappedSpottingsTab
        case tappedSettingsTab
    }

    enum Command {
        case showSpottings
        case showSettings
    }

    mutating func handle(_ event: Event) -> Command {
        switch (self, event) {
        case (.spottings, .tappedSettingsTab):
            self = .settings
            return .showSettings
        case (.settings, .tappedSpottingsTab):
            self = .spottings
            return .showSpottings
        default: fatalError("Event not compatible with current state.")
        }
    }

}
