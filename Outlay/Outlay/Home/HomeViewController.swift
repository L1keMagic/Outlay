import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = Constants.outlayTitle
        configure()
    }
    // MARK: - ExpenseIndicator
    private let expenseIndicator: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.dropShadow()
        return $0
    }(UIView())
    // MARK: - Add action for expense indicator
    @objc func openExpenseList(sender: UITapGestureRecognizer) {
        Logger.information(message: "Expense indicator was touched")
        let expensesData = ExpenseRepository.shared.getExpenses()
        navigationController?.pushViewController(ExpensesListViewController(expenses: expensesData),
                                                 animated: true)
    }
    // MARK: - Add Expense Button
    fileprivate let addExpenseButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.setTitle(NSLocalizedString(Constants.newExpenceTitle, comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        $0.titleLabel?.font = .systemFont(ofSize: 22)
        $0.backgroundColor = Constants.darkBlueColor
        return $0
    }(UIButton())
    // MARK: - Add action for expense button
    @objc func addExpense() {
        Logger.information(message: "expenses button touched")
        present(UINavigationController(rootViewController: NewExpenseViewController()), animated: true)
    }
}

// MARK: - Controller Extention
extension HomeViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(addExpenseButton)
        view.addSubview(expenseIndicator)
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        expenseIndicator.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openExpenseList)))
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        addExpenseButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(18)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(18)
        }
        expenseIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            $0.width.equalToSuperview().inset(18)
            $0.height.equalTo(250)
        }
    }
}
