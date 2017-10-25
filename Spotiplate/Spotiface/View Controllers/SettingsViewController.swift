//
//  Settings.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-09.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

public enum SettingsAction {
    case trackLocationByDefault
    case contact
    case reset
}

extension SettingsAction: TableViewDescriptor {
    public var icon: UIImage? {
        switch self {
        case .trackLocationByDefault: return "🗺".image()
        case .contact: return "💌".image()
        case .reset: return "🗑".image()
        }
    }
    
    public var label: String {
        switch self {
        case .trackLocationByDefault: return "Save spotting locations"
        case .contact: return "Send feedback"
        case .reset: return "Remove all data and start over"
        }
    }
    
    public var detailLabel: String? {
        switch self {
        case .contact: return "Send me an email"
        default: return nil
        }
    }
    
    public var accessory: TableViewDescriptorCellAccessory {
        switch self {
        case .trackLocationByDefault: return .toggle
        default: return .cellAccessory(.none)
        }
    }
    
    public static var layout: [[SettingsAction]] {
        return [
            [.trackLocationByDefault, .contact],
            [.reset]
        ]
    }
    
    public static var sectionHeaders: [Int : String]? {
        return [
            0: "General",
            1: "Reset"
        ]
    }
    
    public static var sectionFooters: [Int : String]? {
        return nil
    }
}

public class SettingsViewController: StaticTableViewController<SettingsAction> {

    private let initialTrackingSetting: Bool
    
    public init(initialTrackingSetting: Bool) {
        self.initialTrackingSetting = initialTrackingSetting
        super.init(style: .grouped)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if indexPath.row == 0 {
            (cell.accessoryView as? UISwitch)?.isOn = initialTrackingSetting
        }
        return cell
    }

}
