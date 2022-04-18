import UIKit

class ExpenceCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Initializing components
    lazy var expenceTitle: UILabel = {
        $0.text = "test text"
        return $0
    }(UILabel())
}

extension ExpenceCell {
    // MARK: - Configure Cell
    internal func configure() {
        addSubviews()
        configureConstraints()
    }
    // MARK: - Subviews
    fileprivate func addSubviews() {
        addSubview(expenceTitle)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        setExpenceTitleConstraints()
    }
    fileprivate func setExpenceTitleConstraints() {
        expenceTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
