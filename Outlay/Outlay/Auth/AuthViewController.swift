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
        $0.distribution = .fillProportionally
        $0.spacing = 20
        return $0
    }(UIStackView())
    lazy var nameField: UITextField = createTextField(tag: 1, placeholder: "Enter name")
    lazy var emailField: UITextField = createTextField(tag: 2, placeholder: "Enter email")
    lazy var passwordField: UITextField = createTextField(tag: 3, placeholder: "Enter password")
    // MARK: - Add action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "continue button touched")
    }
    @objc func sign() {
        Logger.information(message: "Sign button touched")
    }
    @objc func openForgotPassword() {
        Logger.information(message: "Forgot password button touched")
        navigationController?.pushViewController(ResetPasswordViewController(),
                                                 animated: true)
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
        [nameField, emailField, passwordField].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        continueButton.addTarget(self, action: #selector(openHomeVC), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(openForgotPassword), for: .touchUpInside)
        signButton.addTarget(self, action: #selector(sign), for: .touchUpInside)
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
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
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

extension AuthViewController {
    // MARK: - Create TextField
    private func createTextField(tag: Int,
                                 placeholder: String,
                                 keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textColor = .black
        textField.tag = tag
//        textField.delegate = self
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        return textField
    }
}
