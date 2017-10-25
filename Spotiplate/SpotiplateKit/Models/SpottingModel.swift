//
//  SpottingModel.swift
//  SpotiplateKit
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation

public struct SpottingModel: SpottingType {
    public var date: Date
    public var number: Int
    public var letters: String?
    public var longitude: Double?
    public var latitude: Double?
    public var notes: String?

    public init(date: Date, number: Int, letters: String? = nil, lon: Double? = nil, lat: Double? = nil, notes: String? = nil) {
        self.date = date
        self.number = number
        self.letters = letters
        self.longitude = lon
        self.latitude = lat
        self.notes = notes
    }
}
