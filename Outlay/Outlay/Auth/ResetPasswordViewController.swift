import UIKit

class ResetPasswordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    // MARK: - Initializing components
    lazy var titleLabel: UILabel = createDefaultTitleLabel(text: Constants.resetPassword)
    lazy var resetPasswordButton: UIButton = createDefaultContinueButton(text: Constants.resetPassword)
    lazy var emailLabel: UILabel = createDefaultSmallLabel(text: Constants.email)
    lazy var emailField: UITextField = createDefaultTextField(tag: 1, placeholder: Constants.email)
    // MARK: - Action for reset password button
    @objc func resetPassword() {
        Logger.information(message: "Reset password button touched")
    }
}

extension ResetPasswordViewController {
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
        view.addSubview(resetPasswordButton)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
    }
    // MARK: - Delegates
    fileprivate func configureDelegates() {
        emailField.delegate = self
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        resetPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(18)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(18)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-15)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        emailField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).inset(-10)
            $0.width.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
    }
}

extension ResetPasswordViewController: UITextFieldDelegate {
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
