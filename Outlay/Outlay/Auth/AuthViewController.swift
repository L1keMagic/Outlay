import UIKit
import SnapKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Sign Up"
                switchLogInTypeButton.setTitle(NSLocalizedString(Constants.signIn, comment: ""), for: .normal)
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                confirmPasswordLabel.isHidden = false
                confirmPasswordField.isHidden = false
            } else {
                titleLabel.text = "Sign In"
                switchLogInTypeButton.setTitle(NSLocalizedString(Constants.signUp, comment: ""), for: .normal)
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                confirmPasswordLabel.isHidden = true
                confirmPasswordField.isHidden = true
            }
        }
    }
    // MARK: - Initializing components
    lazy var titleLabel: UILabel = {
        $0.text = Constants.signUp.uppercased()
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
    lazy var switchLogInTypeButton: UIButton = {
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
        $0.contentMode = .top
        return $0
    }(UIStackView())
    lazy var emailLabel: UILabel = createLabel(text: "Email")
    lazy var emailField: UITextField = createTextField(tag: 2, placeholder: "Email")
    lazy var passwordLabel: UILabel = createLabel(text: "Password")
    lazy var passwordField: UITextField = createTextField(tag: 3, placeholder: "Password")
    lazy var confirmPasswordLabel: UILabel = createLabel(text: "Confirm password")
    lazy var confirmPasswordField: UITextField = createTextField(tag: 4, placeholder: "Confirm password")
    // MARK: - Add action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "Continue button touched")
    }
    @objc func switchLogInType() {
        Logger.information(message: "Sign button touched")
        signup = !signup
    }
    @objc func openForgotPasswordVC() {
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
        view.addSubview(titleLabel)
        view.addSubview(continueButton)
        view.addSubview(switchLogInTypeButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(stackView)
        [emailLabel,
         emailField,
         passwordLabel,
         passwordField,
         confirmPasswordLabel,
         confirmPasswordField].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        continueButton.addTarget(self, action: #selector(openHomeVC), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(openForgotPasswordVC), for: .touchUpInside)
        switchLogInTypeButton.addTarget(self, action: #selector(switchLogInType), for: .touchUpInside)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        continueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(18)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(18)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
        }
        switchLogInTypeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(stackView.snp.bottom).inset(-15)
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(switchLogInTypeButton.snp.bottom)
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    // MARK: - Create TextField
    private func createTextField(tag: Int,
                                 placeholder: String,
                                 keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.textColor = .black
        textField.tag = tag
        textField.delegate = self
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        return textField
    }
    // MARK: - Create Label
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.moveToNextTFResponder(textField)
        return true
    }
    func moveToNextTFResponder(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}
