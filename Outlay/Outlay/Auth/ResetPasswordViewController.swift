import UIKit

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        configure()
    }
    // MARK: - Initializing components
    lazy var titleLabel: UILabel = {
        $0.text = Constants.resetPassword
        $0.textColor = Constants.darkBlueColor
        $0.font = UIFont.boldSystemFont(ofSize: 24.0)
        return $0
    }(UILabel())
    lazy var resetPasswordButton: UIButton = {
        $0.layer.cornerRadius = 30
        $0.setTitle(NSLocalizedString(Constants.resetPassword, comment: ""), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
        $0.titleLabel?.font = .systemFont(ofSize: 22)
        $0.backgroundColor = Constants.darkBlueColor
        return $0
    }(UIButton())
    lazy var emailField: UITextField = createTextField(tag: 1, placeholder: "Email")
    lazy var emailLabel: UILabel = createLabel(text: "Email")
    // MARK: - Add action for reset password button
    @objc func resetPassword() {
        Logger.information(message: "reset password button touched")
    }
}

extension ResetPasswordViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
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
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
    }
    // MARK: - Configure Constraints
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
