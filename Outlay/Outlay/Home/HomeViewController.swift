import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.blueColor
        title = "Outlay"
        configure()
    }
    // MARK: - ExpenceIndicator
    private let expenceIndicator: UIView = {
        $0.backgroundColor = .yellow
        return $0
    }(UIView())
    // MARK: - Button
    private let addExpenceButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.setTitle(NSLocalizedString("new expence", comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(Constants.blueColor, for: .highlighted)
        $0.backgroundColor = Constants.lightBlueColor
        $0.addTarget(self, action: #selector(addExpence), for: .touchUpInside)
        return $0
    }(UIButton())
    @objc func addExpence() {
        Logger.information(message: "expenses button touched")
        present(UINavigationController(rootViewController: NewExpenceViewController()), animated: true)
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
        addExpenceButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(20)
        }
    }
    // MARK: - Expence Indicator
    private func setExpenceIndicatorConstraints() {
        expenceIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(250)
        }
    }
}
