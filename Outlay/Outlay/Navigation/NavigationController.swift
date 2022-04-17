import UIKit

class NavigationController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    // MARK: - Configure TabBar ViewController
    internal func setupTabBar() {
        // creating home vc
        let homeVC = createNavController(
            viewController: HomeViewController(),
            title: "Home",
            selected: UIImage(systemName: "house")!,
            unselected: UIImage(systemName: "house.fill")!)
        // creating addNewExpence vc
        let addNewVC = createNavController(
            viewController: AddExpenceViewController(),
            title: "New",
            selected: UIImage(systemName: "plus.square")!,
            unselected: UIImage(systemName: "plus.square.fill")!)
        // creating settings vc
        let settingsVC = createNavController(
            viewController: SettingsViewController(),
            title: "Settings",
            selected: UIImage(systemName: "gearshape.2")!,
            unselected: UIImage(systemName: "gearshape.2.fill")!)
        // array of prepared view controllers
        viewControllers = [homeVC, addNewVC, settingsVC]
    }
}
