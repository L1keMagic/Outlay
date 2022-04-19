import UIKit

class ExpencesListViewController: UIViewController {
    private var tableView = UITableView()
    private var expences: Expences
    init(expences: Expences) {
        self.expences = expences
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configureTableView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
// MARK: - Configuring table view
extension ExpencesListViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenceCell.self, forCellReuseIdentifier: Constants.expenceCellIdentifier)
        tableView.backgroundColor = Constants.blueColor
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expences.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenceCellIdentifier,
                                                 for: indexPath) as? ExpenceCell
        let expence = expences[indexPath.row]
        cell?.set(expence: expence)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
