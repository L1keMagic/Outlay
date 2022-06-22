import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

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
    lazy var passwordField: UITextField = createAuthTextField(tag: 2, placeholder: Constants.password, isPasswordField: true)
    lazy var confirmPasswordField: UITextField = createAuthTextField(tag: 3, placeholder: Constants.confirmPassword, isPasswordField: true)
    lazy var switchLogInTypeButton: UIButton = createDefaultSmallButton(text: Constants.signIn)
    lazy var forgotPasswordButton: UIButton = createDefaultSmallButton(text: Constants.forgotPassword)
    lazy var continueButton: UIButton = createDefaultContinueButton(text: Constants.continueButton)
    // MARK: - Action for continue button
    @objc func openHomeVC() {
        Logger.information(message: "Continue button touched")
        // Create cleaned versions of data!
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if signup {
            // Sign Up
            // Validate the fields
            let error = validateFields()
            if error != nil {
                // There is something wrong with the fields! : Show error message!
                Alerts.shared.showInformAlert(on: self, title: Constants.error, message: error!)
            } else {
                // Create the user
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    // Check for Errors
                    if err != nil {
                        // There was an error creating the user
                        Alerts.shared.showInformAlert(on: self, title: Constants.error, message: "Error Creating User")
                    } else {
                        // User was successfully created, now store the first name/last/email/pass
                        let db = Firestore.firestore()
                        db.collection("users")
                            .addDocument(data: ["username": "test user", "uid": result!.user.uid]) { (error) in
                            if error != nil {
                                Alerts.shared.showInformAlert(on: self, title: Constants.error,
                                                              message: "User data could not uploaded, please try again")
                            }
                        }
                    }
                }
            }
        } else {
            // Sign In
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    // Could not sign in
                    Alerts.shared.showInformAlert(on: self, title: Constants.error, message: "Could not sign in")
                }
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
    // Check the fields and validate that the data is correct.  If everything
    // is correct, this method returns nil.  Otherwise it retuns the error message
    func validateFields() -> String? {
        // Check that all fields are filled in
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        // Check if password == confirm password fields
        if passwordField.text != confirmPasswordField.text {
            return "Password and Confirm Password fields should be equal"
        }
        // Check if the email is okay!
        let cleanedEmail = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Validators.isEmailValid(cleanedEmail) == false {
            // Email is not okay
            return "Please make that your email is correct"
        }
        // Check if the password is secure!
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Validators.isPasswordValid(cleanedPassword) == false {
            // Password is not secure enough
            return "Please make sure your password is at least 8 character, contains a special character and number"
        }
        return nil
    }
}
