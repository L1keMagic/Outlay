import UIKit

class ExpencesListViewController: UIViewController {
    // declaration of table view
    private var tableView = UITableView()
    private var expences: Expences = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.expenceCellIdentifier)
        tableView.backgroundColor = Constants.lightBlueColor
        expences.append(Expence(id: 1, title: "Хлеб", price: 100, categoryId: nil, creationDate: nil))
        expences.append(Expence(id: 1, title: "Спайс", price: 10000, categoryId: nil, creationDate: nil))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
// MARK: - Configuring extension
extension ExpencesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expences.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenceCellIdentifier, for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
