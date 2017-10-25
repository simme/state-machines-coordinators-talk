import Foundation
import UIKit

public protocol ItemDetailViewControllerDelegate: class {
    func detailView(_ detailViewController: ItemDetailViewController, requestsLocationDisplayOf item: Item)
}

public class ItemDetailViewController: UIViewController {

    public weak var delegate: ItemDetailViewControllerDelegate?

    private let item: Item

    public init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        self.title = item.name
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(label)
        view.addSubview(viewOnMapButton)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewOnMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewOnMapButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 48),
        ])
    }

    @objc private func viewOnMap() {
        delegate?.detailView(self, requestsLocationDisplayOf: self.item)
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = self.item.name
        return label
    }()

    private lazy var viewOnMapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View on map", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(viewOnMap), for: .touchUpInside)
        return button
    }()

}
