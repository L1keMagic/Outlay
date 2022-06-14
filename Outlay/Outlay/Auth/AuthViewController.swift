import UIKit
import SnapKit
import FirebaseAuth

class AuthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    var logInMode: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = Constants.signUp
                switchLogInTypeButton.setTitle(NSLocalizedString(Constants.signIn, comment: ""), for: .normal)
                emailField.text = ""
                passwordField.text = ""
                confirmPasswordField.text = ""
                confirmPasswordLabel.isHidden = false
                confirmPasswordField.isHidden = false
            } else {
                titleLabel.text = Constants.signIn
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
    lazy var titleLabel: UILabel = createDefaultTitleLabel(text: Constants.signUp)
    lazy var emailLabel: UILabel = createDefaultSmallLabel(text: Constants.email)
    lazy var passwordLabel: UILabel = createDefaultSmallLabel(text: Constants.password)
    lazy var confirmPasswordLabel: UILabel = createDefaultSmallLabel(text: Constants.confirmPassword)
    lazy var emailField: UITextField = createDefaultTextField(tag: 1, placeholder: Constants.email)
    lazy var passwordField: UITextField = createDefaultTextField(tag: 2, placeholder: Constants.password)
    lazy var confirmPasswordField: UITextField = createDefaultTextField(tag: 3, placeholder: Constants.confirmPassword)
    lazy var switchLogInTypeButton: UIButton = createDefaultSmallButton(text: Constants.signIn)
    lazy var forgotPasswordButton: UIButton = createDefaultSmallButton(text: Constants.forgotPassword)
    lazy var continueButton: UIButton = createDefaultContinueButton(text: Constants.continueButton)
    lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.contentMode = .top
        return $0
    }(UIStackView())
    // MARK: - Action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "Continue button touched")
        if !logInMode {
            print("Sign In")
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                      Logger.error(message: "Missing data")
                      return
                  }
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard error == nil else {
                    print("Failed")
                    return
                }
                Logger.information(message: "You signed in")
            }
        } else {
            print("Sing Up")
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty,
                  let passwordConfirm = confirmPasswordField.text, !passwordConfirm.isEmpty,
                  password == passwordConfirm  else {
                      Logger.error(message: "Missing data")
                      return
                  }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard error == nil else {
                    print("Failed")
                    return
                }
            }
        }
    }
    @objc func switchLogInType() {
        Logger.information(message: "Sign button touched")
        logInMode = !logInMode
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
