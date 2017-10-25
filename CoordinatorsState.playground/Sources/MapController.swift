import Foundation
import UIKit
import MapKit

public class MapController: UIViewController {

    var item: Item

    public init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        self.title = "I'm on a map!"
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let annotation = MKPointAnnotation()
        annotation.coordinate = self.item.coordinate
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: false)
    }

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

}

extension Item {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.location.lat, longitude: self.location.lon)
    }
}
