import UIKit

class ExpenceCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Initializing components
    lazy var expenceTitle: UILabel = {
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20.0)
        return $0
    }(UILabel())
    lazy var expencePrice: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    lazy var expenceDate: UILabel = {
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
}

extension ExpenceCell {
    // MARK: - Filling Cell
    func set(expence: Expence) {
        expenceTitle.text = expence.title
        expencePrice.text = "\(expence.price)"
        expenceDate.text = expence.creationDate
    }
    // MARK: - Subviews
    fileprivate func addSubviews() {
        addSubview(expenceTitle)
        addSubview(expencePrice)
        addSubview(expenceDate)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        expenceTitle.snp.makeConstraints {
            $0.left.equalToSuperview().inset(5)
            $0.top.equalToSuperview()
        }
        expencePrice.snp.makeConstraints {
            $0.left.equalToSuperview().inset(5)
            $0.top.equalTo(expenceTitle.snp.bottom)
        }
        expenceDate.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(expenceTitle.snp.bottom)
        }
    }
}
