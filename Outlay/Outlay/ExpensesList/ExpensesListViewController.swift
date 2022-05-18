import UIKit

class ExpensesListViewController: UIViewController {
    private var tableView = UITableView()
    private var expensesDto: ExpensesDto
    init(expensesDto: ExpensesDto) {
        self.expensesDto = expensesDto
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
extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseCell.self, forCellReuseIdentifier: Constants.expenseDtoCellIdentifier)
        tableView.backgroundColor = Constants.backgroundAppColor
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesDto.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenseDtoCellIdentifier,
                                                 for: indexPath) as? ExpenseCell
        let expenseDto = expensesDto[indexPath.row]
        cell?.set(expenseDto: expenseDto)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
