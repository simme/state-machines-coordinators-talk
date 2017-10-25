//
//  TabBarDelegate.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

/**
 A mini-wrapper around the `UITabBarControllerDelegate` protocol that just forwards tab selection changes.
 */
public final class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    
    /// The function called when the tab is changed.
    public var tabSelectionCallback: ((Int, UIViewController) -> Void)?
    
    class public func delegate(withCallback callback: @escaping (Int, UIViewController) -> Void) -> TabBarDelegate {
        let delegate = TabBarDelegate()
        delegate.tabSelectionCallback = callback
        return delegate
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabSelectionCallback?(tabBarController.selectedIndex, viewController)
    }
    
}
