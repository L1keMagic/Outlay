import UIKit

class NavigationController: UINavigationController {
    var initialVC: UIViewController
    init(initialVC: UIViewController) {
        self.initialVC = initialVC
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [initialVC]
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.barStyle = .default
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.darkBlueColor]
        self.navigationBar.tintColor = Constants.darkBlueColor
    }
}
