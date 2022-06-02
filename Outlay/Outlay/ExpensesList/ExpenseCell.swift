import UIKit

class ExpenseCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Initializing components
    lazy var expenseTitle: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return $0
    }(UILabel())
    lazy var categoryTitle: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.textColor = UIColor.gray
        return $0
    }(UILabel())
    lazy var expensePrice: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return $0
    }(UILabel())
}

extension ExpenseCell {
    // MARK: - Filling Cell
    func set(expense: Expense) {
        expenseTitle.text = expense.title
        categoryTitle.text = "\(expense.categoryTitle)"
        expensePrice.text = String(expense.price)
    }
    // MARK: - Subviews
    fileprivate func addSubviews() {
        addSubview(expenseTitle)
        addSubview(categoryTitle)
        addSubview(expensePrice)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        expenseTitle.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.top.equalToSuperview().inset(Constants.defaultTopInset/3)
        }
        categoryTitle.snp.makeConstraints {
            $0.left.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.top.equalTo(expenseTitle.snp.bottom)
            $0.bottom.equalToSuperview().inset(Constants.defaultBottomInset/3)
        }
        expensePrice.snp.makeConstraints {
            $0.right.equalToSuperview().inset(Constants.defaultRightInset)
            $0.top.equalToSuperview().inset(Constants.defaultTopInset/3)
        }
    }
}
