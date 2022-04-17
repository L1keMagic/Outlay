import UIKit

extension UITabBarController {
    func createNavController(viewController: UIViewController,
                             title: String,
                             selected: UIImage,
                             unselected: UIImage
    ) -> UINavigationController {
        let viewController = viewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        navController.navigationBar.barTintColor = Constants.navBarColor
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Constants.navBarColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        }
        return navController
    }
}
