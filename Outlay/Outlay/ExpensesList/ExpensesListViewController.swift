import UIKit

class ExpensesListViewController: UIViewController {
    private var tableView = UITableView()
    private var expenses: Expenses
    private var groupedExpenses = [Expenses]()
    init(expenses: Expenses) {
        self.expenses = expenses
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        groupExpenses()
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
        tableView.register(ExpenseCell.self, forCellReuseIdentifier: Constants.expenseCellIdentifier)
        tableView.backgroundColor = Constants.backgroundAppColor
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedExpenses[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenseCellIdentifier,
                                                 for: indexPath) as? ExpenseCell
        let expense = groupedExpenses[indexPath.section][indexPath.row]
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
        return groupedExpenses.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let date = groupedExpenses[section].first?.expenseDate
        label.text = "\(date!)"
        label.backgroundColor = .white
//        DOES NOT WORK HERE, NEEDS FIX
//        label.snp.makeConstraints {
//            $0.left.equalToSuperview().inset(5)
//            $0.top.equalToSuperview().inset(5)
//            $0.bottom.equalToSuperview().inset(5)
//        }
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
extension ExpensesListViewController {
    func groupExpenses() {
        print("attempt to group expenses")
        let groupedByDate = Dictionary(grouping: expenses) { (expense) -> String in
            return expense.expenseDate
        }
        let keys = groupedByDate.keys.sorted(by: >)
        keys.forEach({
            groupedExpenses.append(groupedByDate[$0]!)
        })
        tableView.reloadData()
    }
}
