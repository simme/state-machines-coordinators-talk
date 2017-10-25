//
//  TableViewDescriptor.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-09.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import UIKit

public enum TableViewDescriptorCellAccessory {
    case cellAccessory(UITableViewCellAccessoryType)
    case toggle
}

public protocol TableViewDescriptor {
    var icon: UIImage? { get }
    var label: String { get }
    var detailLabel: String? { get }
    var accessory: TableViewDescriptorCellAccessory { get }
    static var layout: [[Self]] { get }
    init(indexPath: IndexPath)
    func configure(cell: UITableViewCell)
    
    static var sectionHeaders: [Int: String]? { get }
    static var sectionFooters: [Int: String]? { get }
}

public class CallbackSwitch: UISwitch {
    var callback: (Bool) -> Void
    
    init(callback: @escaping (Bool) -> Void) {
        self.callback = callback
        super.init(frame: .zero)
        addTarget(self, action: #selector(toggled), for: .valueChanged)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func toggled() {
        callback(isOn)
    }
}

extension TableViewDescriptor {
    
    public init(indexPath: IndexPath) {
        self = Self.layout[indexPath.section][indexPath.row]
    }
    
    public func configure(cell: UITableViewCell) {
        cell.textLabel?.text = self.label
        cell.imageView?.image = self.icon
        cell.detailTextLabel?.text = self.detailLabel
        
        cell.accessoryType = .none
        cell.accessoryView = nil
    }
}
