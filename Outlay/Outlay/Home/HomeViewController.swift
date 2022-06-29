import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private var expenses: Expenses
    init(expenses: Expenses) {
        self.expenses = expenses
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Lables and Shapes
    let monthBudget = { getBudget(period: .month) }
    let weekBudget = { getBudget(period: .week) }
    let todayBudget = { getBudget(period: .today) }
    // Month labels
    let monthOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: Constants.monthCircleLabelText)
    let monthOutlaySpentLabel = UILabel()
    let monthOutlayBudgetLabel = UILabel()
    let monthOutlayAvailableLabel = UILabel()
    // Today labels
    let todayOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: Constants.todayCircleLabelText)
    let todayOutlaySpentLabel = UILabel()
    let todayOutlayBudgetLabel = UILabel()
    let todayOutlayAvailableLabel = UILabel()
    // Week labels
    let weekOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: Constants.weekCircleLabelText)
    let weekOutlaySpentLabel = UILabel()
    let weekOutlayBudgetLabel = UILabel()
    let weekOutlayAvailableLabel = UILabel()
    // Month circle shapes
    let monthOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 65,
                                                                      lineWidth: 12,
                                                                      centerX: 89,
                                                                      centerY: 89)
    let monthOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 65,
                                                                                lineWidth: 12,
                                                                                centerX: 89,
                                                                                centerY: 89)
    // Today circle shapes
    let todayOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 25,
                                                                      lineWidth: 8,
                                                                      centerX: 47,
                                                                      centerY: 47)
    let todayOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 25,
                                                                                lineWidth: 8,
                                                                                centerX: 47,
                                                                                centerY: 47)
    // Week circle shapes
    let weekOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 25,
                                                                     lineWidth: 8,
                                                                     centerX: 47,
                                                                     centerY: 47)
    let weekOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 25,
                                                                               lineWidth: 8,
                                                                               centerX: 47,
                                                                               centerY: 47)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = Constants.outlayTitle
        configure()
    }
    // MARK: - ExpenseIndicator
    private let monthOutlayProgress: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    private let todayOutlayProgress: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    private let weekOutlayProgress: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    // MARK: - Action for expense indicator
    @objc func openExpenseList(sender: UITapGestureRecognizer) {
        Logger.information(message: "Expense indicator was touched")
        let groupedExpenses = ExpenseRepository.shared.getGroupedExpenses()
        navigationController?.pushViewController(ExpensesListViewController(expenses: groupedExpenses),
                                                 animated: true)
    }
    // MARK: - Add Expense Button
    fileprivate let addMonthBudgetButton: UIButton = createDefaultSmallButton(text: Constants.addMonthBudgetButtonTitle)
    fileprivate let addExpenseButton: UIButton = createDefaultContinueButton(text: Constants.newExpenceTitle)
    // MARK: - Add action for expense button
    @objc func addExpense() {
        Logger.information(message: "expenses button touched")
        let categories = CategoryRepository.shared.getCategories()
        present(UINavigationController(rootViewController: NewExpenseViewController(categories: categories)),
                animated: true)
    }
    // MARK: - Add action for settings button
    @objc func openSettings() {
        Logger.information(message: "settigs button touched")
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
// MARK: - Controller Extention
extension HomeViewController {
    // MARK: - Configure View
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
        animateAllCircles()
        configureLables()
        configureButtonSettings()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        [addExpenseButton,
         monthOutlayProgress,
         todayOutlayProgress,
         weekOutlayProgress].forEach {
            view.addSubview($0)
        }
        [monthOutlayProgressTrackCircle,
         monthOutlayProgressCircle].forEach {
            monthOutlayProgress.layer.addSublayer($0)
        }
        [todayOutlayProgressTrackCircle,
         todayOutlayProgressCircle].forEach {
            todayOutlayProgress.layer.addSublayer($0)
        }
        [weekOutlayProgressTrackCircle,
         weekOutlayProgressCircle].forEach {
            weekOutlayProgress.layer.addSublayer($0)
        }
        [monthOutlayCircleLabel,
         monthOutlaySpentLabel,
         monthOutlayBudgetLabel,
         monthOutlayAvailableLabel].forEach {
            monthOutlayProgress.addSubview($0)
        }
        [todayOutlayCircleLabel,
         todayOutlaySpentLabel,
         todayOutlayBudgetLabel,
         todayOutlayAvailableLabel].forEach {
            todayOutlayProgress.addSubview($0)
        }
        [weekOutlayCircleLabel,
         weekOutlaySpentLabel,
         weekOutlayBudgetLabel,
         weekOutlayAvailableLabel].forEach {
            weekOutlayProgress.addSubview($0)
        }
        monthOutlayProgress.addSubview(addMonthBudgetButton)
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        monthOutlayProgress.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                        action: #selector(openExpenseList)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openSettings))
    }
    // MARK: - Button Settings
    fileprivate func configureButtonSettings() {
        addMonthBudgetButton.backgroundColor = Constants.darkBlueColor
        addMonthBudgetButton.layer.cornerRadius = 15
        addMonthBudgetButton.titleLabel?.font = .systemFont(ofSize: 16)
        addMonthBudgetButton.setTitleColor(.white, for: .normal)
        addMonthBudgetButton.setTitleColor(UIColor.lightGray, for: .highlighted)
    }
    // MARK: - Lables Settings
    fileprivate func configureLables() {
        // today
        todayOutlayBudgetLabel.textColor = UIColor.gray
        todayOutlayBudgetLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlayBudgetLabelText)
            .bold("\(String(describing: todayBudget()))")
        todayOutlaySpentLabel.textColor = UIColor.gray
        todayOutlaySpentLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlaySpentLabelText)
            .bold("\(getMoneySpentAmountForPeriod(period: .day, expenses: expenses))")
        todayOutlayAvailableLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlayAvailableLabelText)
            .bold("\(Double(todayBudget()) - (getMoneySpentAmountForPeriod(period: .day, expenses: expenses)))")
        todayOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        // week
        weekOutlayBudgetLabel.textColor = UIColor.gray
        weekOutlayBudgetLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlayBudgetLabelText)
            .bold("\(String(describing: weekBudget()))")
        weekOutlaySpentLabel.textColor = UIColor.gray
        weekOutlaySpentLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlaySpentLabelText)
            .bold("\(getMoneySpentAmountForPeriod(period: .weekOfMonth, expenses: expenses))")
        weekOutlayAvailableLabel.attributedText =
        NSMutableAttributedString()
            .normal(Constants.todayOutlayAvailableLabelText)
            .bold("\(Double(weekBudget()) - getMoneySpentAmountForPeriod(period: .weekOfMonth, expenses: expenses))")
        weekOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        // month
        monthOutlayBudgetLabel.textAlignment = .right
        monthOutlayBudgetLabel.numberOfLines = 2
        monthOutlayBudgetLabel.attributedText =
        NSMutableAttributedString()
            .grayBold(Constants.monthOutlayBudgetLabelText)
            .largeBold("\n\(String(describing: monthBudget()))")
        monthOutlaySpentLabel.textAlignment = .right
        monthOutlaySpentLabel.numberOfLines = 2
        monthOutlaySpentLabel.attributedText =
        NSMutableAttributedString()
            .grayBold(Constants.monthOutlaySpentLabelText)
            .largeBold("\n\(getMoneySpentAmountForPeriod(period: .month, expenses: expenses))")
        monthOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        addExpenseButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.defaultLeftInset)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
        }
        monthOutlayProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(178)
        }
        todayOutlayProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(monthOutlayProgress.snp.bottom).inset(-18)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(94)
        }
        weekOutlayProgress.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(todayOutlayProgress.snp.bottom).inset(-18)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(94)
        }
        monthOutlayCircleLabel.snp.makeConstraints {
            $0.centerX.equalTo(monthOutlayProgressCircle.position.x)
            $0.centerY.equalTo(monthOutlayProgressCircle.position.y)
        }
        todayOutlayCircleLabel.snp.makeConstraints {
            $0.left.equalTo(todayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(todayOutlayBudgetLabel.snp.top)
        }
        todayOutlayBudgetLabel.snp.makeConstraints {
            $0.left.equalTo(todayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(todayOutlaySpentLabel.snp.top)
        }
        todayOutlaySpentLabel.snp.makeConstraints {
            $0.left.equalTo(todayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalToSuperview().inset(18)
        }
        todayOutlayAvailableLabel.snp.makeConstraints {
            $0.left.equalTo(todayOutlayBudgetLabel.snp.right).inset(-18)
            $0.bottom.equalTo(todayOutlaySpentLabel.snp.top)
        }
        weekOutlayCircleLabel.snp.makeConstraints {
            $0.left.equalTo(weekOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(weekOutlayBudgetLabel.snp.top)
        }
        weekOutlayBudgetLabel.snp.makeConstraints {
            $0.left.equalTo(weekOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(weekOutlaySpentLabel.snp.top)
        }
        weekOutlaySpentLabel.snp.makeConstraints {
            $0.left.equalTo(weekOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalToSuperview().inset(18)
        }
        weekOutlayAvailableLabel.snp.makeConstraints {
            $0.left.equalTo(weekOutlayBudgetLabel.snp.right).inset(-18)
            $0.bottom.equalTo(weekOutlaySpentLabel.snp.top)
        }
        monthOutlayBudgetLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(18)
            $0.bottom.equalTo(monthOutlaySpentLabel.snp.top)
        }
        monthOutlaySpentLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(18)
            $0.bottom.equalTo(addMonthBudgetButton.snp.top).inset(-5)
        }
        addMonthBudgetButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.right.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
    // MARK: Circles animations
    fileprivate func animateAllCircles() {
        monthOutlayProgressCircle.add(animateCircle(numerator: Int(getMoneySpentAmountForPeriod(period: .month,
                                                                                                expenses: expenses)),
                                                    denominator: monthBudget(),
                                                    duration: 0.6),
                                      forKey: "monthOutlayProgressCircle")
        todayOutlayProgressCircle.add(animateCircle(numerator: Int((getMoneySpentAmountForPeriod(period: .day,
                                                                                                 expenses: expenses))),
                                                    denominator: todayBudget(),
                                                    duration: 0.6),
                                      forKey: "todayOutlayProgressCircle")
        weekOutlayProgressCircle.add(animateCircle(numerator: Int(getMoneySpentAmountForPeriod(period: .weekOfMonth,
                                                                                               expenses: expenses)),
                                                   denominator: weekBudget(),
                                                   duration: 0.6),
                                     forKey: "weekOutlayProgressCircle")
    }
}
