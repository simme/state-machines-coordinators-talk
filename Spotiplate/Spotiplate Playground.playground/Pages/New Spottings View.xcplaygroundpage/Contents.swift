import Foundation
import UIKit
import PlaygroundSupport
import Spotiface
import SpotiplateKit

class Delegate: NewSpottingViewControllerDelegate {
    func saveSpotting(
        withNumbers numbers: Int,
        letters: String?,
        storeLocation: Bool,
        notes: String?
    ) {
        print("Store \(letters ?? "ABC") \(numbers), storeLocation: \(storeLocation)\n\(notes ?? "")")
    }
    
    func storeLocationToggled(on: Bool) {
        print("Store location: \(on)")
    }
}

var del = Delegate()

let newSpotting = NewSpottingViewController(number: 3, isLocationToggled: true)
newSpotting.delegate = del
let navigationController = UINavigationController(rootViewController: newSpotting)
let (parent, _) = playgroundControllers(
    device: .phone4_7inch,
    orientation: .portrait,
    child: navigationController)

PlaygroundPage.current.liveView = parent.view
