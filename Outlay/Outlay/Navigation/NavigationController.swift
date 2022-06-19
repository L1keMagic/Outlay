import UIKit

class NavigationController: UINavigationController {
    var isLogged: Bool
    init(isLogged: Bool) {
        self.isLogged = isLogged
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogged {
            self.viewControllers = [HomeViewController()]
        } else {
            self.viewControllers = [AuthViewController()]
        }
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.barStyle = .default
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.darkBlueColor]
        self.navigationBar.tintColor = Constants.darkBlueColor
    }
}
