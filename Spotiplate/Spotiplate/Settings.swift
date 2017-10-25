//
//  Settings.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-10.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

final class Settings {
    
    enum Key: String {
        case trackLocationByDefault
    }
    
    private lazy var defaults = UserDefaults.standard
    
    var trackLocationByDefault: Bool {
        get {
            return defaults.bool(forKey: Settings.Key.trackLocationByDefault.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Settings.Key.trackLocationByDefault.rawValue)
        }
    }
    
}
