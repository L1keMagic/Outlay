import UIKit

class ExpensesListViewController: UIViewController {
    private var tableView = UITableView()
    private var expenses: [Expenses]
    init(expenses: [Expenses]) {
        self.expenses = expenses
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        ExpenseRepository.shared.clearGroupedExpenses()
    }
}
// MARK: - Configuring table view
extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseCell.self, forCellReuseIdentifier: Constants.expenseCellIdentifier)
        tableView.backgroundColor = Constants.backgroundAppColor
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenseCellIdentifier,
                                                 for: indexPath) as? ExpenseCell
        let expense = expenses[indexPath.section][indexPath.row]
        cell?.set(expense: expense)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return expenses.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let date = expenses[section].first?.expenseDate
        label.text = "\(date ?? Constants.defaultDate)"
        label.backgroundColor = .white
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
