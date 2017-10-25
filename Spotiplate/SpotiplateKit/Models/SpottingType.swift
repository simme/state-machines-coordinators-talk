//
//  SpottingType.swift
//  SpotiplateKit
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation

public protocol SpottingType: Codable {
    var date: Date { get }
    var number: Int { get }
    var letters: String? { get }
    var longitude: Double? { get }
    var latitude: Double? { get }
    var notes: String? { get }
}

extension SpottingType {
    public var displayTitle: String {
        let paddedNumbers = String(format: "%03d", number)
        let letters = self.letters ?? "ABC"
        return "\(letters) \(paddedNumbers)"
    }
}
