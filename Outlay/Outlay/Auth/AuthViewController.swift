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
        $0.text = Constants.signUP.uppercased()
        $0.textColor = Constants.darkBlueColor
        $0.font = UIFont.boldSystemFont(ofSize: 24.0)
        return $0
    }(UILabel())
    lazy var continueButton: UIButton = {
        $0.layer.cornerRadius = 30
        $0.setTitle(NSLocalizedString(Constants.continueButton, comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        $0.titleLabel?.font = .systemFont(ofSize: 22)
        $0.backgroundColor = Constants.darkBlueColor
        return $0
    }(UIButton())
    lazy var signButton: UIButton = {
        $0.setTitle(NSLocalizedString(Constants.signIn, comment: ""), for: .normal)
        $0.setTitleColor(Constants.darkBlueColor, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        return $0
    }(UIButton())
    lazy var forgotPasswordButton: UIButton = {
        $0.setTitle(NSLocalizedString(Constants.forgotPassword, comment: ""), for: .normal)
        $0.setTitleColor(Constants.darkBlueColor, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        return $0
    }(UIButton())
    lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView())
    // MARK: - Add action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "continue button touched")
    }
    @objc func sign() {
        Logger.information(message: "Sign button touched")
    }
    @objc func openForgotPassword() {
        Logger.information(message: "Forgot password button touched")
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
        view.addSubview(signButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(stackView)
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
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLablel.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(signButton.snp.top)
        }
        signButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signButton.snp.bottom)
        }
    }
}
