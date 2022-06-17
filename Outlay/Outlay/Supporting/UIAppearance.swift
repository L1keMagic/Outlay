import UIKit

public class UneditableTextField: UITextField {
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}

public func createDefaultTitleLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = Constants.darkBlueColor
    label.font = UIFont.boldSystemFont(ofSize: 24.0)
    return label
}

public func createDefaultSmallLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    return label
}

public func createDefaultTextField(tag: Int,
                                   placeholder: String,
                                   keyboardType: UIKeyboardType = .default,
                                   textFieldType: UITextField = UITextField()) -> UITextField {
    let textField = textFieldType
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
func createDefaultHeaderInSectionView(header: UILabel) -> UIView {
    let defaultDateLabelView = UIView()
    defaultDateLabelView.addSubview(header)
    header.snp.makeConstraints {
        $0.left.equalToSuperview()
        $0.top.equalToSuperview().inset(Constants.defaultTopInset/3)
        $0.bottom.equalToSuperview().inset(Constants.defaultBottomInset/3)
    }
    return defaultDateLabelView
}
