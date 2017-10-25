import Foundation
import UIKit

public protocol ItemsTableViewControllerDelegate: class {
    func didSelectItem(_ item: Item)
}

public class ItemsTableViewController: UITableViewController {

    public weak var delegate: ItemsTableViewControllerDelegate?

    private let items: [Item]

    public init(items: [Item]) {
        self.items = items
        super.init(style: .plain)
        self.title = "Places"
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(items[indexPath.row])
    }

}
