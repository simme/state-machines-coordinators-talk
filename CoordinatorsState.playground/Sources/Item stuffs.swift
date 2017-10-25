import Foundation

public struct Item {
    public typealias Coordinate = (lat: Double, lon: Double)
    public let name: String
    public let location: Coordinate

    public init(name: String, location: Coordinate) {
        self.name = name
        self.location = location
    }
}
