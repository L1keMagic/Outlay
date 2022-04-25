import UIKit

func createDefaultTitleLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = Constants.darkBlueColor
    label.font = UIFont.boldSystemFont(ofSize: 24.0)
    return label
}

func createDefaultSmallLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    return label
}

func createDefaultTextField(tag: Int, placeholder: String,
                            keyboardType: UIKeyboardType = .default) -> UITextField {
    let textField = UITextField()
    textField.layer.cornerRadius = 5
    textField.textColor = .black
    textField.tag = tag
    textField.placeholder = placeholder
    textField.keyboardType = keyboardType
    return textField
}

func createDefaultContinueButton(text: String) -> UIButton {
    let button = UIButton()
    button.layer.cornerRadius = 30
    button.setTitle(NSLocalizedString(text, comment: ""), for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
    button.titleLabel?.font = .systemFont(ofSize: 22)
    button.backgroundColor = Constants.darkBlueColor
    return button
}

func createDefaultSmallButton(text: String) -> UIButton {
    let button = UIButton()
    button.setTitle(NSLocalizedString(text, comment: ""), for: .normal)
    button.setTitleColor(Constants.darkBlueColor, for: .normal)
    button.setTitleColor(Constants.backgroundAppColor, for: .highlighted)
    return button
}
