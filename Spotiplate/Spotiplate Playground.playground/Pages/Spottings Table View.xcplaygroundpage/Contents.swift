import Foundation
import UIKit
import PlaygroundSupport
import Spotiface
import SpotiplateKit

let models: [SpottingModel] = [
    SpottingModel(date: Date(), number: 1),
    SpottingModel(date: Date(), number: 2),
    SpottingModel(date: Date(), number: 3),
    SpottingModel(date: Date(), number: 4),
    SpottingModel(date: Date(), number: 5),
    SpottingModel(date: Date(), number: 6)
    ].sorted { (a, b) -> Bool in
        return a.number > b.number
    }

let spottings = SpottingsTableViewController(spottings: models)
let navigationController = UINavigationController(rootViewController: spottings)
let (parent, _) = playgroundControllers(
    device: .phone4_7inch,
    orientation: .portrait,
    child: navigationController)

PlaygroundPage.current.liveView = parent.view
