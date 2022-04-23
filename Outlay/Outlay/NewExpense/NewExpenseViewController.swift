import UIKit

class NewExpenseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = "Insert expence"
        configure()
    }
    // MARK: - TextFields
    lazy var titleTF: UITextField = createTextField(tag: 1, placeholder: "Title")
    lazy var categoryTF: UITextField = createTextField(tag: 2, placeholder: "Category")
    lazy var priceTF: UITextField = createTextField(tag: 3, placeholder: "Price", keyboardType: .decimalPad)
    // calendar view
    lazy var dateLabel: UILabel = createDateLabel()
    lazy var calendarButton: UIButton = createCalendarButton()
    lazy var dateCalendarView: UIView = UIView()
    // MARK: - DatePicker
    let datePicker = UIDatePicker()
    // MARK: - Add action for save new expence button
    @objc func saveNewExpence() {
        Logger.information(message: "save new expence touched")
        let newExpenseVM = NewExpenseViewModel(title: titleTF.text,
                                               price: priceTF.text,
                                               categoryId: categoryTF.text,
                                               creationDate: dateLabel.text)
        print(dateLabel.text)
        print(categoryTF.text)
        let result = newExpenseVM.insertData()
        if result == "Ok" {
            Logger.information(message: "Data was successfuly inserted")
            self.dismiss(animated: true)
        } else {
            Logger.warning(message: "Please fill all the fields")
        }
    }
    // MARK: - Add action for back button
    @objc func backButton() {
        self.dismiss(animated: true)
    }
    // MARK: - Add action for calendar
    @objc func openCalendar() {
        Logger.information(message: "open calendar button touched")
    }
    @objc func dateChange(datePicker: UIDatePicker) {
        let dateManager = DateManager()
        let rawDatePickerDate = dateManager.getDateUTC(datePicker.date)
        dateLabel.text = dateManager.getFormattedDateUTCtoDMMYYYY(rawDatePickerDate)
        dateLabel.backgroundColor = Constants.backgroundAppColor
    }
}

extension NewExpenseViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
        createDatePicker()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(titleTF)
        view.addSubview(priceTF)
        view.addSubview(categoryTF)
        view.addSubview(dateCalendarView)
        dateCalendarView.addSubview(datePicker)
        dateCalendarView.addSubview(calendarButton)
    }
    // MARK: - Configure Actions
    fileprivate func configureActions() {
        // MARK: - Save button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self, action:
                                                                    #selector(saveNewExpence))
        // MARK: - Back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(backButton))
        calendarButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
    }
    // MARK: - Configure Constraints
    fileprivate func configureConstraints() {
        titleTF.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        categoryTF.snp.makeConstraints {
            $0.top.equalTo(titleTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        priceTF.snp.makeConstraints {
            $0.top.equalTo(categoryTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        dateCalendarView.snp.makeConstraints {
            $0.top.equalTo(priceTF.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
//        dateLabel.snp.makeConstraints {
//            $0.left.equalToSuperview()
//            $0.height.equalTo(35)
//        }
        calendarButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        datePicker.snp.makeConstraints {
//            $0.top.equalTo(dateTF.snp.bottom).inset(-10)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(35)
//            $0.width.equalToSuperview().inset(10)
            $0.left.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
    // MARK: - Create TextField
    private func createTextField(tag: Int,
                                 placeholder: String,
                                 keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = Constants.backgroundAppColor
        textField.layer.cornerRadius = 5
        textField.textColor = .black
        textField.tag = tag
        textField.delegate = self
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType

        return textField
    }
    // MARK: - Create Label
    private func createDateLabel() -> UILabel {
        let label = UILabel()
        let dateManager = DateManager()
        let unformattedDate = dateManager.getCurrentDateUTC()
        label.text = dateManager.getFormattedDateUTCtoDMMYYYY(unformattedDate)
        label.backgroundColor = Constants.backgroundAppColor
        return label
    }
    // MARK: - Create Date Calendar View
    private func createCalendarButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        return button
    }
    // MARK: - Create Date Picker
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
//        datePicker.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
//        let dateManager = DateManager()
//        let unformattedDate = dateManager.getCurrentDateUTC()
//        dateLabel.text = dateManager.getFormattedDateUTCtoDMMYYYY(unformattedDate)
      return
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
