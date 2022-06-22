import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let currentPercentage = 0.5
    let dayPercentage = 0.3
    let weekPercentage = 0.8
    let currentOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 90,
                                                                 lineWidth: 12,
                                                                 centerX: 115,
                                                                 centerY: 115)
    let currentOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 90,
                                                                           lineWidth: 12,
                                                                           centerX: 115,
                                                                           centerY: 115)
    let dayOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 40,
                                                                    lineWidth: 8,
                                                                    centerX: 290,
                                                                    centerY: 62)
    let dayOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 40,
                                                                           lineWidth: 8,
                                                                           centerX: 290,
                                                                           centerY: 62)
    let weekOutlayProgressCircle: CAShapeLayer = createExpenseCircle(radius: 40,
                                                                    lineWidth: 8,
                                                                    centerX: 290,
                                                                    centerY: 168)
    let weekOutlayProgressTrackCircle: CAShapeLayer = createExpenseTrackCircle(radius: 40,
                                                                           lineWidth: 8,
                                                                           centerX: 290,
                                                                           centerY: 168)
    let currentOutlayProgressLabel: UILabel = createDefaultSmallLabel(text: "Month")
    let dayOutlayProgressLabel: UILabel = createDefaultSmallLabel(text: "Today")
    let weekOutlayProgressLabel: UILabel = createDefaultSmallLabel(text: "Week")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = Constants.outlayTitle
        currentOutlayProgressLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dayOutlayProgressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        weekOutlayProgressLabel.font = UIFont.boldSystemFont(ofSize: 14)
        configure()
    }
    // MARK: - ExpenseIndicator
    private let expenseIndicator: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
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

    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(addExpenseButton)
        view.addSubview(expenseIndicator)
        expenseIndicator.layer.addSublayer(currentOutlayProgressTrackCircle)
        expenseIndicator.layer.addSublayer(currentOutlayProgressCircle)
        expenseIndicator.layer.addSublayer(dayOutlayProgressTrackCircle)
        expenseIndicator.layer.addSublayer(dayOutlayProgressCircle)
        expenseIndicator.layer.addSublayer(weekOutlayProgressTrackCircle)
        expenseIndicator.layer.addSublayer(weekOutlayProgressCircle)
        expenseIndicator.addSubview(currentOutlayProgressLabel)
        expenseIndicator.addSubview(dayOutlayProgressLabel)
        expenseIndicator.addSubview(weekOutlayProgressLabel)
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        expenseIndicator.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openExpenseList)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openSettings))
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        addExpenseButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.defaultLeftInset)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
        }
        expenseIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
            $0.height.equalTo(expenseIndicator.snp.width)
        }
        currentOutlayProgressLabel.snp.makeConstraints {
            $0.centerX.equalTo(currentOutlayProgressCircle.position.x)
            $0.centerY.equalTo(currentOutlayProgressCircle.position.y)
        }
        dayOutlayProgressLabel.snp.makeConstraints {
            $0.centerX.equalTo(dayOutlayProgressCircle.position.x)
            $0.centerY.equalTo(dayOutlayProgressCircle.position.y)
        }
        weekOutlayProgressLabel.snp.makeConstraints {
            $0.centerX.equalTo(weekOutlayProgressCircle.position.x)
            $0.centerY.equalTo(weekOutlayProgressCircle.position.y)
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
        currentOutlayProgressCircle.add(currentAnimation, forKey: "urSoBasic")
        dayOutlayProgressCircle.add(dayAnimation, forKey: "urSoBasic")
        weekOutlayProgressCircle.add(weekAnimation, forKey: "urSoBasic")
    }
}
