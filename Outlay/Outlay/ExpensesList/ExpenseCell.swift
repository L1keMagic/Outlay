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
        $0.font = UIFont.boldSystemFont(ofSize: 20.0)
        return $0
    }(UILabel())
    lazy var expensePrice: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    lazy var expenseDate: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
}

extension ExpenseCell {
    // MARK: - Filling Cell
    func set(expenseDto: ExpenseDto) {
        expenseTitle.text = expenseDto.title
        expensePrice.text = "\(expenseDto.price)"
        expenseDate.text = expenseDto.expenseDate
    }
    // MARK: - Subviews
    fileprivate func addSubviews() {
        addSubview(expenseTitle)
        addSubview(expensePrice)
        addSubview(expenseDate)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        expenseTitle.snp.makeConstraints {
            $0.left.equalToSuperview().inset(5)
            $0.top.equalToSuperview()
        }
        expensePrice.snp.makeConstraints {
            $0.left.equalToSuperview().inset(5)
            $0.top.equalTo(expenseTitle.snp.bottom)
        }
        expenseDate.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(expenseTitle.snp.bottom)
        }
    }
}
