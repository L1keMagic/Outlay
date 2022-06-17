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
        title = "Insert expence"
        configure()
    }
    // MARK: - TextFields
    lazy var titleField: UITextField = createDefaultTextField(tag: 1, placeholder: "Title")
    lazy var categoryField: UITextField = createDefaultTextField(tag: 2,
                                                                 placeholder: "Category",
                                                                 textFieldType: UneditableTextField())
    lazy var categoryId = UILabel()
    lazy var priceField: UITextField = createDefaultTextField(tag: 3, placeholder: "Price", keyboardType: .decimalPad)
    // calendar view
    lazy var expenseDateLabel: UILabel = createDateLabel()
    lazy var calendarImage: UIImageView = createCalendarImage()
    lazy var dateCalendarView: UIView = UIView()
    // MARK: - DatePicker
    let datePicker = UIDatePicker()
    // MARK: - CategoryPicker
    let categoryPicker = UIPickerView()
    // MARK: - Add action for save new expence button
    @objc func saveNewExpence() {
        Logger.information(message: "save new expence touched")
        let newExpenseVM = NewExpenseViewModel()
        do {
            try newExpenseVM.insertData(model: NewExpenseModel(title: titleField.text,
                                                               price: priceField.text,
                                                               categoryId: categoryId.text,
                                                               expenseDate: expenseDateLabel.text))
            self.dismiss(animated: true)
            Logger.information(message: "Data was successfuly inserted")
        } catch ExpenseError.validationError {
            let alert = UIAlertController(title: Constants.error, message:
                                            Constants.invalidFieldsInserted,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel))
            self.present(alert, animated: true)
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
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(titleField)
        view.addSubview(priceField)
        view.addSubview(categoryField)
        view.addSubview(dateCalendarView)
        dateCalendarView.addSubview(datePicker)
        dateCalendarView.addSubview(calendarImage)
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
        titleField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        categoryField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        priceField.snp.makeConstraints {
            $0.top.equalTo(categoryField.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        dateCalendarView.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview().inset(10)
        }
        calendarImage.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        datePicker.snp.makeConstraints {
            $0.left.equalTo(calendarImage.snp.right).inset(-10)
            $0.height.equalTo(35)
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
        let image = UIImage(systemName: "calendar")
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
