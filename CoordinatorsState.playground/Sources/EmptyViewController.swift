import Foundation
import UIKit

public protocol EmptyViewControllerDelegate: class {
    func addStuff()
}

public class EmptyViewController: UIViewController {

    public weak var delegate: EmptyViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Empty List"

        view.addSubview(label)
        view.addSubview(addStuffButton)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addStuffButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStuffButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 48)
        ])
    }

    @objc private func addStuff() {
        delegate?.addStuff()
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = "No stuff here :("
        return label
    }()

    private lazy var addStuffButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add stuff", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addStuff), for: .touchUpInside)
        return button
    }()

    override public var keyCommands: [UIKeyCommand] {
        let addStuff = UIKeyCommand(input: "\r", modifierFlags: [], action: #selector(self.addStuff))

        return [addStuff]
    }

}
