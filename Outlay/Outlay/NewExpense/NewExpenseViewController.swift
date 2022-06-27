import UIKit

class NewExpenseViewController: UIViewController {
    private var categories = Categories()
    init(categories: Categories) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = Constants.addNewExpenseTitle
        configure()
    }
    // MARK: - Labels
    lazy var titleLabel: UILabel = createDefaultSmallLabel(text: Constants.newExpenseTitleLabelField)
    lazy var categoryLabel: UILabel = createDefaultSmallLabel(text: Constants.newExpenseCategoryLabelField)
    lazy var priceLabel: UILabel = createDefaultSmallLabel(text: Constants.newExpensePriceLabelField)
    // MARK: - TextFields
    lazy var titleField: UITextField = createDefaultTextField(tag: 1,
                                                              placeholder: Constants.newExpenseTitleTextField,
                                                              textAlignment: .right)
    lazy var categoryField: UITextField = createDefaultTextField(tag: 2,
                                                                 placeholder: Constants.newExpenseCategoryTextField,
                                                                 textAlignment: .right,
                                                                 textFieldType: UneditableTextField())
    lazy var categoryId = UILabel()
    lazy var priceField: UITextField = createDefaultTextField(tag: 3,
                                                                  placeholder: Constants.newExpensePriceTextField,
                                                              textAlignment: .right,
                                                                  keyboardType: .decimalPad)
    lazy var expenseDateLabel: UILabel = createDateLabel()
    lazy var calendarImage: UIImageView = createCalendarImage()
    lazy var newExpenseFieldsView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    lazy var dateCalendarView: UIView = UIView()
    // MARK: - DatePicker
    let datePicker = UIDatePicker()
    // MARK: - CategoryPicker
    let categoryPicker = UIPickerView()
    // MARK: - Add action for save new expence button
    @objc func saveNewExpence() {
        Logger.information(message: Constants.saveNewExpenseBtnTouched)
        let newExpenseVM = NewExpenseViewModel()
        do {
            try newExpenseVM.insertData(model: NewExpenseModel(title: titleField.text,
                                                               price: priceField.text,
                                                               categoryId: categoryId.text,
                                                               expenseDate: expenseDateLabel.text))
            self.dismiss(animated: true)
            Logger.information(message: Constants.successDataInsert)
        } catch ExpenseError.validationError {
            Alerts.shared.showInformAlert(on: self, title: Constants.error, message: Constants.invalidFieldsInserted)
        } catch {
            Logger.error(message: Constants.unknownError)
        }
    }
    // MARK: - Actions
    @objc func backButton() {
        self.dismiss(animated: true)
    }
    @objc func didExpenseDateCnahged(datePicker: UIDatePicker) {
        let dateManager = DateManager()
        expenseDateLabel.text = dateManager.convertDateFormat(date: datePicker.date,
                                                              outputFormat: Constants.dateFormatDMY)
        presentedViewController?.dismiss(animated: true, completion: nil)
        priceField.resignFirstResponder()
    }
    @objc func dismissCategoryPicker() {
        categoryField.resignFirstResponder()
        moveToNextTFResponder(categoryField)
    }
}

extension NewExpenseViewController {
    // MARK: - Views
    fileprivate func configure() {
        configureSubviews()
        configureDelegates()
        configureActions()
        configureConstraints()
        createDatePicker()
        createCategoryPicker()
        createCategoryPickerToolbar()
        configureFonts()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(newExpenseFieldsView)
        newExpenseFieldsView.addSubview(titleLabel)
        newExpenseFieldsView.addSubview(titleField)
        newExpenseFieldsView.addSubview(categoryLabel)
        newExpenseFieldsView.addSubview(categoryField)
        newExpenseFieldsView.addSubview(priceLabel)
        newExpenseFieldsView.addSubview(priceField)
        newExpenseFieldsView.addSubview(dateCalendarView)
        dateCalendarView.addSubview(datePicker)
        dateCalendarView.addSubview(calendarImage)
    }
    fileprivate func configureFonts() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        categoryLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        priceLabel.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    // MARK: - Delegates
    fileprivate func configureDelegates() {
        titleField.delegate = self
        categoryField.delegate = self
        priceField.delegate = self
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        // MARK: - Save button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self, action:
                                                                    #selector(saveNewExpence))
        self.navigationItem.rightBarButtonItem?.tintColor = Constants.darkBlueColor
        // MARK: - Back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(backButton))
        self.navigationItem.leftBarButtonItem?.tintColor = Constants.darkBlueColor
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        newExpenseFieldsView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(215)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.left.equalToSuperview().inset(15)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(15)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(15)
        }
        dateCalendarView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(15)
        }
        titleField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(50)
            $0.right.equalToSuperview().inset(15)
        }
        categoryField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom)
            $0.height.equalTo(50)
            $0.right.equalToSuperview().inset(15)
        }
        priceField.snp.makeConstraints {
            $0.top.equalTo(categoryField.snp.bottom)
            $0.height.equalTo(50)
            $0.right.equalToSuperview().inset(15)
        }
        dateCalendarView.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(15)
        }
        calendarImage.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalTo(35)
        }
        datePicker.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    // MARK: - Date Label
    private func createDateLabel() -> UILabel {
        let label = UILabel()
        let dateManager = DateManager()
        label.text = dateManager.getCurrentDate(dateFormat: Constants.dateFormatDMY)
        label.backgroundColor = Constants.backgroundAppColor
        return label
    }
    // MARK: - Date Calendar View
    private func createCalendarImage() -> UIImageView {
        let image = UIImage(systemName: Constants.calendarImage)
        let imageView = UIImageView(image: image)
        imageView.tintColor = Constants.darkBlueColor
        return imageView
    }
    // MARK: - Date Picker
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self,
                             action: #selector(didExpenseDateCnahged(datePicker:)),
                             for: UIControl.Event.valueChanged)
        return
    }
    // MARK: - Category Picker
    private func createCategoryPicker() {
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        self.categoryField.inputView = categoryPicker
        categoryPicker.backgroundColor = Constants.backgroundAppColor
    }
    private func createCategoryPickerToolbar() {
        let categoryPickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 35))
        categoryPickerToolBar.barTintColor = .white
        categoryPickerToolBar.tintColor = Constants.darkBlueColor
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(self.dismissCategoryPicker))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                     target: self,
                                     action: nil)
        categoryPickerToolBar.setItems([spacer, spacer, doneButton], animated: true)
        self.categoryField.inputAccessoryView = categoryPickerToolBar
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
extension NewExpenseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryField.text = categories[row].title
        categoryId.text = categories[row].categoryId
    }
}
