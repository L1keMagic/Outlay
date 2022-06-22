import UIKit
import SnapKit

class HomeViewController: UIViewController {
    // MARK: Lables and Shapes
    let currentPercentage = 0.5
    let dayPercentage = 0.3
    let weekPercentage = 0.8
    let monthOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: "Month")
    let monthOutlaySpentLabel = UILabel()
    let monthOutlayBudgetLabel = UILabel()
    let monthOutlayAvailableLabel: UILabel = createDefaultSmallLabel(text: "Available")
    let dayOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: "Today")
    let dayOutlaySpentLabel = UILabel()
    let dayOutlayBudgetLabel = UILabel()
    let dayOutlayAvailableLabel: UILabel = createDefaultSmallLabel(text: "Available")
    let weekOutlayCircleLabel: UILabel = createDefaultSmallLabel(text: "Week")
    let weekOutlaySpentLabel = UILabel()
    let weekOutlayBudgetLabel = UILabel()
    let weekOutlayAvailableLabel: UILabel = createDefaultSmallLabel(text: "Available")
    let monthOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 65,
                                                                 lineWidth: 12,
                                                                 centerX: 89,
                                                                 centerY: 89)
    let monthOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 65,
                                                                           lineWidth: 12,
                                                                           centerX: 89,
                                                                           centerY: 89)
    let dayOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 25,
                                                                    lineWidth: 8,
                                                                    centerX: 47,
                                                                    centerY: 47)
    let dayOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 25,
                                                                           lineWidth: 8,
                                                                           centerX: 47,
                                                                           centerY: 47)
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
    private let monthExpenseIndicator: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    private let dayExpenseIndicator: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.dropShadow()
        return $0
    }(UIView())
    private let weekExpenseIndicator: UIView = {
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
    fileprivate let addMonthBudgetButton: UIButton = createDefaultSmallButton(text: "Set budget")
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
        animateCircle()
        configureLables()
        configureButtonSettings()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(addExpenseButton)
        view.addSubview(monthExpenseIndicator)
        view.addSubview(dayExpenseIndicator)
        view.addSubview(weekExpenseIndicator)
        monthExpenseIndicator.layer.addSublayer(monthOutlayProgressTrackCircle)
        monthExpenseIndicator.layer.addSublayer(monthOutlayProgressCircle)
        dayExpenseIndicator.layer.addSublayer(dayOutlayProgressTrackCircle)
        dayExpenseIndicator.layer.addSublayer(dayOutlayProgressCircle)
        weekExpenseIndicator.layer.addSublayer(weekOutlayProgressTrackCircle)
        weekExpenseIndicator.layer.addSublayer(weekOutlayProgressCircle)
        monthExpenseIndicator.addSubview(monthOutlayCircleLabel)
        monthExpenseIndicator.addSubview(monthOutlaySpentLabel)
        monthExpenseIndicator.addSubview(monthOutlayBudgetLabel)
        monthExpenseIndicator.addSubview(monthOutlayAvailableLabel)
        dayExpenseIndicator.addSubview(dayOutlayCircleLabel)
        dayExpenseIndicator.addSubview(dayOutlaySpentLabel)
        dayExpenseIndicator.addSubview(dayOutlayBudgetLabel)
        dayExpenseIndicator.addSubview(dayOutlayAvailableLabel)
        weekExpenseIndicator.addSubview(weekOutlayCircleLabel)
        weekExpenseIndicator.addSubview(weekOutlaySpentLabel)
        weekExpenseIndicator.addSubview(weekOutlayBudgetLabel)
        weekExpenseIndicator.addSubview(weekOutlayAvailableLabel)
        monthExpenseIndicator.addSubview(addMonthBudgetButton)
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        monthExpenseIndicator.addGestureRecognizer(UITapGestureRecognizer(target: self,
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
        dayOutlayBudgetLabel.textColor = UIColor.gray
        dayOutlayBudgetLabel.attributedText =
            NSMutableAttributedString()
            .normal("Budget: ")
            .bold("\(1500)")
        dayOutlaySpentLabel.textColor = UIColor.gray
        dayOutlaySpentLabel.attributedText =
            NSMutableAttributedString()
            .normal("Spent: ")
            .bold("\(750)")
        dayOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        weekOutlayBudgetLabel.textColor = UIColor.gray
        weekOutlayBudgetLabel.attributedText =
            NSMutableAttributedString()
            .normal("Budget: ")
            .bold("\(10500)")
        weekOutlaySpentLabel.textColor = UIColor.gray
        weekOutlaySpentLabel.attributedText =
            NSMutableAttributedString()
            .normal("Spent: ")
            .bold("\(750)")
        weekOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        monthOutlayBudgetLabel.textAlignment = .right
        monthOutlayBudgetLabel.numberOfLines = 2
        monthOutlayBudgetLabel.attributedText =
        NSMutableAttributedString()
            .grayBold("Expenses budget")
            .largeBold("\n\(42000)")
        monthOutlaySpentLabel.textAlignment = .right
        monthOutlaySpentLabel.numberOfLines = 2
        monthOutlaySpentLabel.attributedText =
        NSMutableAttributedString()
            .grayBold("Money spent")
            .largeBold("\n\(1500)")
        monthOutlayCircleLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        dayOutlayProgressTrackCircle.strokeColor = UIColor.clear.cgColor
//        dayOutlayProgressTrackCircle.fillColor = UIColor(red: 255/255,
//                                                         green: 214/255,
//                                                         blue: 183/255,
//                                                         alpha: 0.4).cgColor
//        weekOutlayProgressTrackCircle.strokeColor = UIColor.clear.cgColor
//        weekOutlayProgressTrackCircle.fillColor = UIColor(red: 255/255,
//                                                         green: 214/255,
//                                                         blue: 183/255,
//                                                         alpha: 0.4).cgColor
//        monthOutlayProgressTrackCircle.strokeColor = UIColor.clear.cgColor
//        monthOutlayProgressTrackCircle.fillColor = UIColor(red: 255/255,
//                                                         green: 214/255,
//                                                         blue: 183/255,
//                                                         alpha: 0.4).cgColor
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        addExpenseButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.defaultLeftInset)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
        }
        monthExpenseIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(178)
        }
        dayExpenseIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(monthExpenseIndicator.snp.bottom).inset(-18)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(94)
        }
        weekExpenseIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dayExpenseIndicator.snp.bottom).inset(-18)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(94)
        }
        monthOutlayCircleLabel.snp.makeConstraints {
            $0.centerX.equalTo(monthOutlayProgressCircle.position.x)
            $0.centerY.equalTo(monthOutlayProgressCircle.position.y)
        }
        dayOutlayCircleLabel.snp.makeConstraints {
            $0.left.equalTo(dayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(dayOutlayBudgetLabel.snp.top)
        }
        dayOutlayBudgetLabel.snp.makeConstraints {
            $0.left.equalTo(dayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalTo(dayOutlaySpentLabel.snp.top)
        }
        dayOutlaySpentLabel.snp.makeConstraints {
            $0.left.equalTo(dayOutlayProgressCircle.position.x).inset(94)
            $0.bottom.equalToSuperview().inset(18)
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

    fileprivate func animateCircle() {
        let currentAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let dayAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let weekAnimation = CABasicAnimation(keyPath: "strokeEnd")
        currentAnimation.toValue = currentPercentage
        currentAnimation.duration = 0.6
        currentAnimation.fillMode = CAMediaTimingFillMode.forwards
        currentAnimation.isRemovedOnCompletion = false
        dayAnimation.toValue = dayPercentage
        dayAnimation.duration = 0.6
        dayAnimation.fillMode = CAMediaTimingFillMode.forwards
        dayAnimation.isRemovedOnCompletion = false
        weekAnimation.toValue = weekPercentage
        weekAnimation.duration = 0.6
        weekAnimation.fillMode = CAMediaTimingFillMode.forwards
        weekAnimation.isRemovedOnCompletion = false
        monthOutlayProgressCircle.add(currentAnimation, forKey: "urSoBasic")
        dayOutlayProgressCircle.add(dayAnimation, forKey: "urSoBasic")
        weekOutlayProgressCircle.add(weekAnimation, forKey: "urSoBasic")
    }
}
