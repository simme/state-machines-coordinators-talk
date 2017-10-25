//
//  AppDelegate.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-03.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if self.applicationCoordinator == nil {
            self.applicationCoordinator = ApplicationCoordinator()
        }
        self.window?.rootViewController = self.applicationCoordinator?.rootViewController
        ApplicationContext.createContext { context in
            self.applicationCoordinator?.context = context
            self.applicationCoordinator?.start(with: {
                self.window?.makeKeyAndVisible()
            })
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        applicationCoordinator?.isActive = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        applicationCoordinator?.isActive = true
    }

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        applicationCoordinator?.encode(with: coder)
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        self.applicationCoordinator = ApplicationCoordinator(coder: coder)
        return true
    }

}
