import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [HomeViewController()]
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.barStyle = .default
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.darkBlueColor]
        self.navigationBar.tintColor = Constants.darkBlueColor
    }
}
