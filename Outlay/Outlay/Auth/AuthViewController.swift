import UIKit
import SnapKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    // MARK: - Initializing components
    lazy var titleLablel: UILabel = {
        $0.text = "SIGN UP"
        $0.textColor = Constants.darkBlueColor
        $0.font = UIFont.boldSystemFont(ofSize: 24.0)
        return $0
    }(UILabel())
    lazy var continueButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.setTitle(NSLocalizedString(Constants.continueButton, comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        $0.titleLabel?.font = .systemFont(ofSize: 22)
        $0.backgroundColor = Constants.darkBlueColor
        return $0
    }(UIButton())
    // MARK: - Add action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "continue button touched")
    }
}

extension AuthViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(titleLablel)
        view.addSubview(continueButton)
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        continueButton.addTarget(self, action: #selector(openHomeVC), for: .touchUpInside)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        titleLablel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(50)
        }
        continueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(18)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(18)
        }
    }
}
