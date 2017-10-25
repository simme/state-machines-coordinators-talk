//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport
import Spotiface

let settings = SettingsViewController(initialTrackingSetting: false)
settings.toggleSwitched = { action, isOn in
    switch action {
    case .trackLocationByDefault: print("Track location", isOn)
    default: break
    }
}

settings.selectionCallback = { action, vc in
    vc.tableView.indexPathsForSelectedRows?
        .forEach { vc.tableView.deselectRow(at: $0, animated: true) }
    print(action)
}

let nav = UINavigationController(rootViewController: settings)
let (parent, _) = playgroundControllers(device: .phone4_7inch,
                                        orientation: .portrait,
                                        child: nav)

PlaygroundPage.current.liveView = parent.view

