//
//  SpottingsTableViewController.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit
import SpotiplateKit

public protocol SpottingsTableViewControllerDelegate: class {
    func newSpottingRequested(from spottingsTableViewController: SpottingsTableViewController)
}

public final class SpottingsTableViewController: UITableViewController {

    public var spottings: [SpottingModel] {
        didSet {
            tableView.reloadData()
        }
    }

    public weak var delegate: SpottingsTableViewControllerDelegate?

    public init(spottings: [SpottingModel] = []) {
        self.spottings = spottings
        super.init(style: .plain)
        self.title = "Spottings"
        self.navigationItem.rightBarButtonItem = addButton
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        return button
    }()

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spottings.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let spotting = self.spotting(at: indexPath)
        cell.textLabel?.text = spotting.displayTitle
        cell.detailTextLabel?.text = format(date: spotting.date)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    private func spotting(at indexPath: IndexPath) -> SpottingModel {
        return spottings[indexPath.row]
    }
    
    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    @objc private func addNew(sender: Any?) {
        delegate?.newSpottingRequested(from: self)
    }

    public override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "n", modifierFlags: .command, action: #selector(addNew))
        ]
    }
}
