//
//  UITableView+Extensions.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-10.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func deselectAllRows() {
        self.indexPathsForSelectedRows?
            .forEach { self.deselectRow(at: $0, animated: true) }
    }
}
