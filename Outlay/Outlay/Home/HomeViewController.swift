import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        title = "Outlay"
        configure()
    }
    // MARK: - ExpenceIndicator
    private let expenceIndicator: UIView = {
        $0.backgroundColor = .yellow
        $0.tintColor = .green
        return $0
    }(UIView())
    // MARK: - Button
    private let addExpenceButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.setTitle(NSLocalizedString("new expence", comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(UIColor(red: 237/255, green: 243/255, blue: 249/255, alpha: 1.0), for: .highlighted)
        $0.backgroundColor = UIColor(red: 2/255, green: 177/255, blue: 242/255, alpha: 1.0)
        $0.addTarget(self, action: #selector(addExpence), for: .touchUpInside)
        return $0
    }(UIButton())
    @objc func addExpence() {
    }
}

// MARK: - Controller Extention
extension HomeViewController {
    // MARK: - Configure View
    private func configure() {
        addSubviews()
        configureConstraints()
    }
    // MARK: - SubViews
    private func addSubviews() {
        view.addSubview(addExpenceButton)
        view.addSubview(expenceIndicator)
    }
    // MARK: - Configure Constraints
    private func configureConstraints() {
        setSubmitButtonConstraints()
        setExpenceIndicatorConstraints()
    }
    // MARK: - Button Constraints
    private func setSubmitButtonConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            addExpenceButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20),
            addExpenceButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            addExpenceButton.heightAnchor.constraint(equalToConstant: 60),
            addExpenceButton.widthAnchor.constraint(equalTo: margins.widthAnchor)
        ])
    }
    // MARK: - Expence Indicator
    private func setExpenceIndicatorConstraints() {
    }
}
