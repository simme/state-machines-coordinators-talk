//
//  SpottingsRepository.swift
//  SpotiplateKit
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import CoreLocation

public final class SpottingsRepository {

    // MARK: Properties

    private let dbPath: String
    private let dbFileName: String = "Spottings.json"
    private var dbURL: URL {
        return URL(fileURLWithPath: dbPath).appendingPathComponent(dbFileName)
    }

    public private(set) var spottings: [SpottingModel] = []

    // MARK: Initialization

    public init(dbDirectoryPath: String) throws {
        self.dbPath = dbDirectoryPath
        print("Loaded database from: \(dbURL)")
        try self.loadSpottings()
    }

    // MARK: API

    public func addSpotting(ofNumber number: Int, withLetters letters: String? = nil, at location: CLLocation? = nil, notes: String? = nil) {
        let spotting = SpottingModel(date: Date(),
                                     number: number,
                                     letters: letters,
                                     lon: location?.coordinate.longitude,
                                     lat: location?.coordinate.latitude,
                                     notes: notes)
        spottings.append(spotting)
        performSave()
    }
    
    public func removeAll() {
        spottings.removeAll()
        performSave()
    }

    // MARK: Persistence

    private func loadSpottings() throws {
        var data: Data!
        do {
            data = try Data(contentsOf: dbURL)
        } catch {
            // Most likely means the file does not exist. Just carry on.
            return
        }
        let parser = JSONDecoder()
        let parsed = try parser.decode([SpottingModel].self, from: data)
        spottings = parsed
    }

    private func save() throws {
        let serializer = JSONEncoder()
        let encoded = try serializer.encode(spottings)
        try encoded.write(to: dbURL, options: .atomicWrite)
    }
    
    private func performSave() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                try self?.save()
            } catch {
                print("Failed to save spottings.")
            }
        }
    }

}
