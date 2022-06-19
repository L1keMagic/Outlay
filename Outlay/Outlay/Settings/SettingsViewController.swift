import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundAppColor
        title = Constants.settings
        configure()
    }
    // MARK: - Log out button
    fileprivate let logOutButton: UIButton = createDefaultContinueButton(text: Constants.logOut)
    // MARK: - Add action for log out button
    @objc func logOut() {
        Logger.information(message: "Log out button touched")
        do {
            try Auth.auth().signOut()
            Logger.information(message: "Log out succesfully")
        } catch {
            Logger.error(message: "Error of logging out")
        }
    }
}

extension SettingsViewController {
    // MARK: - Configure Views
    fileprivate func configure() {
        configureSubviews()
        configureActions()
        configureConstraints()
    }
    // MARK: - SubViews
    fileprivate func configureSubviews() {
        view.addSubview(logOutButton)
    }
    // MARK: - Actions
    fileprivate func configureActions() {
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    // MARK: - Constraints
    fileprivate func configureConstraints() {
        logOutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.defaultLeftInset)
            $0.height.equalTo(60)
            $0.width.equalToSuperview().inset(Constants.defaultLeftInset)
        }
    }
}
