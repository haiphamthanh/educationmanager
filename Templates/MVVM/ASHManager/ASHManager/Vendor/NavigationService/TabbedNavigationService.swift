

//class TabbedNavigationService: TabbedNavigationServiceProtocol {
//
//    // MARK: Properties
//
//    var visibleViewController: UIViewController? {
//        return self.selectedNavigationController.visibleViewController
//    }
//    var topViewController: UIViewController? {
//        return self.selectedNavigationController.topViewController
//    }
//    var viewControllers: [UIViewController] {
//        return self.selectedNavigationController.viewControllers
//    }
//    var selectedNavigationController: UINavigationController {
//        return self.tabBarController.selectedViewController! as! UINavigationController
//    }
//    var containerViewController: UIViewController {
//        return self.tabBarController
//    }
//
//    private var registry: ServiceRegistryProtocol
//    private var tabBarController: UITabBarController
//
//    // MARK: Initialization
//
//    required init(registry: ServiceRegistryProtocol) {
//        self.registry = registry
//        self.tabBarController = UITabBarController()
//    }
//
//    // MARK: TabbedNavigationService
//
//    var rootNavigationControllers: [UINavigationController] {
//        return self.tabBarController.viewControllers as! [UINavigationController]
//    }
//    var moreNavigationController: UINavigationController {
//        return self.moreNavigationController
//    }
//
//    func setupWithTabBarController(tabBarController: UITabBarController) {
//        self.tabBarController = tabBarController
//    }
//
//    func selectNavigationController(navigationController: UINavigationController) {
//        self.tabBarController.selectedViewController = navigationController
//    }
//
//    // MARK: NavigationService
//
//    func setViewControllers(viewControllers: [UIViewController], animated: Bool) {
//        self.selectedNavigationController.setViewControllers(viewControllers, animated: animated)
//    }
//
//    func pushViewController(viewController: UIViewController, animated: Bool) {
//        self.selectedNavigationController.pushViewController(viewController, animated: animated)
//    }
//
//    func popViewController(animated: Bool) {
//        self.selectedNavigationController.popViewController(animated: animated)
//    }
//
//    func popToViewController(viewController: UIViewController, animated: Bool) {
//        self.selectedNavigationController.popToViewController(viewController, animated: animated)
//    }
//
//    func popToRootViewController(animated: Bool) {
//        self.selectedNavigationController.popToRootViewController(animated: animated)
//    }
//
//    // MARK:
//
//    func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
//        self.selectedNavigationController.present(viewController, animated: animated, completion: completion)
//    }
//
//    func dismissViewControllerAnimated(animated: Bool, completion: (() -> Void)?) {
//        self.selectedNavigationController.dismiss(animated: animated, completion: completion)
//    }
//
//    // MARK:
//
//    func showViewController(viewController: UIViewController, sender: AnyObject?) {
//        self.selectedNavigationController.show(viewController, sender: sender)
//    }
//
//    func showDetailViewController(viewController: UIViewController, sender: AnyObject?) {
//        self.selectedNavigationController.showDetailViewController(viewController, sender: sender)
//    }
//}

