import UIKit

class NewExpenseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundBlueColor
        title = "Insert expence"
        configure()
    }
    // MARK: - TextFields
    lazy var titleTF: UITextField = createTextField(tag: 1, placeholder: "Title")
    lazy var priceTF: UITextField = createTextField(tag: 2, placeholder: "Price")
    lazy var categoryTF: UITextField = createTextField(tag: 3, placeholder: "Category")
    lazy var creationDateTF: UITextField = createTextField(tag: 4, placeholder: "Date")
}

extension NewExpenseViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(titleTF)
        view.addSubview(priceTF)
        view.addSubview(categoryTF)
        view.addSubview(creationDateTF)
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        titleTF.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        priceTF.snp.makeConstraints {
            $0.top.equalTo(titleTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        categoryTF.snp.makeConstraints {
            $0.top.equalTo(priceTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        creationDateTF.snp.makeConstraints {
            $0.top.equalTo(categoryTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
    }
    // MARK: - Create TextField
    private func createTextField(tag: Int, placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Constants.backgroundBlueColor
        textField.layer.cornerRadius = 5
        textField.textColor = .black
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.tag = tag
        textField.delegate = self
        textField.placeholder = placeholder
        return textField
    }
}

extension NewExpenseViewController: UITextFieldDelegate {
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
