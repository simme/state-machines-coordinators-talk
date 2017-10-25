//
//  ApplicationContext.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-06.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import CoordinatorKit
import SpotiplateKit

/**
 A context holder can hold a context object.
 */
protocol ContextHolding {

    /// The context itself.
    var context: ApplicationContext? { get set }

}


class ApplicationContext {

    public static func createContext(_ callback: (ApplicationContext) -> Void) {
        let context = ApplicationContext()
        callback(context)
    }

    lazy var repository: SpottingsRepository = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        do {
            return try SpottingsRepository(dbDirectoryPath: documentsPath)
        } catch let error {
            fatalError("Failed to initialize spottings repository: \(error.localizedDescription)")
        }
    }()

    lazy var settings: Settings = Settings()
}

extension ContextHolding where Self: Coordinating {

    /**
     Passes the current context down to our children.
     */
    func passContextToChildren() {
        childCoordinators.values.forEach {
            if var holder = $0 as? ContextHolding & Coordinating {
                holder.context = self.context
                holder.passContextToChildren()
            }
        }
    }

}
