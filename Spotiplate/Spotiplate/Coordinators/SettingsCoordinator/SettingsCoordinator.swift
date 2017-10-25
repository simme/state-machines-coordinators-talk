//
//  SettingsCoordinator.swift
//  Spotiplate
//
//  Created by Simon Ljungberg on 2017-10-10.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit
import CoordinatorKit
import Spotiface

final class SettingsCoordinator: NavigationCoordinator, ContextHolding {

    var context: ApplicationContext? {
        didSet {
            passContextToChildren()
        }
    }

    override func start(with callback: @escaping () -> Void) {
        rootViewController.pushViewController(settingsController, animated: false)
        rootViewController.tabBarItem.title = "Settings"
        super.start(with: callback)
    }
    
    private lazy var settingsController: SettingsViewController = {
        let settings = SettingsViewController(initialTrackingSetting: self.context?.settings.trackLocationByDefault ?? false)
        settings.selectionCallback = self.settingsCellSelected
        settings.toggleSwitched = self.settingsToggled
        return settings
    }()
    
    // MARK: Settings Callbacks
    
    private func settingsToggled(setting: SettingsAction, isOn: Bool) {
        switch setting {
        case .trackLocationByDefault:
            context?.settings.trackLocationByDefault = isOn
            break
        default: break
        }
    }
    
    private func settingsCellSelected(
        setting: SettingsAction,
        in settingsViewController: StaticTableViewController<SettingsAction>
    ) {
        settingsViewController.tableView.deselectAllRows()
        switch setting {
        case .reset: confirmResetSpottings()
        default: fatalError("💩")
        }
    }
    
    // MARK: Actions
    
    private func confirmResetSpottings() {
        let alert = UIAlertController(title: "Really start over?",
                                      message: "This cannot be undone.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yup, delete it all!", style: .destructive, handler: { [weak self] (action) in
            self?.context?.repository.removeAll()
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Noooo!", style: .default, handler: { [weak self] (action) in
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }))
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
