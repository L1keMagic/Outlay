import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [HomeViewController()]
        self.navigationBar.prefersLargeTitles = true
    }
}
