import UIKit
import SnapKit
import FirebaseAuth

class AuthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = Constants.signUp
                switchLogInTypeButton.setTitle(NSLocalizedString(Constants.signIn, comment: ""), for: .normal)
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                confirmPasswordField.isHidden = false
            } else {
                titleLabel.text = Constants.signIn
                switchLogInTypeButton.setTitle(NSLocalizedString(Constants.signUp, comment: ""), for: .normal)
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                confirmPasswordField.isHidden = true
            }
        }
    }
    // MARK: - Initializing components
    lazy var titleLabel: UILabel = createDefaultTitleLabel(text: Constants.signUp)
    lazy var emailField: UITextField = createAuthTextField(tag: 1, placeholder: Constants.email)
    lazy var passwordField: UITextField = createAuthTextField(tag: 2, placeholder: Constants.password)
    lazy var confirmPasswordField: UITextField = createAuthTextField(tag: 3, placeholder: Constants.confirmPassword)
    lazy var switchLogInTypeButton: UIButton = createDefaultSmallButton(text: Constants.signIn)
    lazy var forgotPasswordButton: UIButton = createDefaultSmallButton(text: Constants.forgotPassword)
    lazy var continueButton: UIButton = createDefaultContinueButton(text: Constants.continueButton)
    // MARK: - Action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "Continue button touched")
        if signup {
            // Sign Up
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty,
                  let passwordConfirm = confirmPasswordField.text, !passwordConfirm.isEmpty,
                  password == passwordConfirm  else {
                      Alerts.shared.showInformAlert(on: self, title: Constants.error,
                                                    message: Constants.invalidFieldsInserted)
                      return
                  }
            let logInManager = FirebaseAuthManager()
            logInManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if success {
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                Alerts.shared.showInformAlert(on: self, title: nil, message: message)
            }
        } else {
            // Sign In
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                      Alerts.shared.showInformAlert(on: self, title: Constants.error,
                                                    message: Constants.invalidFieldsInserted)
                      return
                  }
            let logInManager = FirebaseAuthManager()
            logInManager.signIn(email: email, password: password) {[weak self] (success) in
            }
        }
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
    // MARK: - Views
    fileprivate func configure() {
        configureSubviews()
        configureDelegates()
        configureActions()
        configureConstraints()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(continueButton)
        view.addSubview(switchLogInTypeButton)
        view.addSubview(forgotPasswordButton)
        [emailField,
         passwordField,
         confirmPasswordField].forEach {
            view.addSubview($0)
        }
    }
    // MARK: - Delegates
    fileprivate func configureDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        continueButton.addTarget(self, action: #selector(openHomeVC), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(openForgotPasswordVC), for: .touchUpInside)
        switchLogInTypeButton.addTarget(self, action: #selector(switchLogInType), for: .touchUpInside)
    }
    // MARK: - Constraints
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
        emailField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-40)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).inset(-20)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        confirmPasswordField.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).inset(-20)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        switchLogInTypeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(confirmPasswordField.snp.bottom).inset(-35)
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(switchLogInTypeButton.snp.bottom)
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
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
