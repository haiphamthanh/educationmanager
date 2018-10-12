

import UIKit

class BasicNavigationService: BasicNavigationServiceProtocol {
	// MARK: Initialization
	required init() {
		self.navigationController = UINavigationController()
	}
	
	convenience init(from window: UIWindow?) {
		self.init()
		
		guard let window = window, let nav = window.topMostWindowController() as? GKExNavigationController else {
			return
		}
		
		self.setupWithNavigationController(navigationController: nav)
	}
	
	// MARK: Properties
	
	var visibleViewController: UIViewController? {
		return self.topNavigationController.visibleViewController
	}
	
	var topViewController: UIViewController? {
		get {
			var viewController: UIViewController = self.navigationController
			while viewController.presentedViewController != nil {
				viewController = viewController.presentedViewController!
			}
			
			if viewController.isKind(of: UINavigationController.self) {
				if let vc = (viewController as! UINavigationController).topViewController {
					viewController = vc
				}
			}
			return viewController
		}
	}
	
	var viewControllers: [UIViewController] {
		return topNavigationController.viewControllers
	}
	var selectedNavigationController: UINavigationController {
		return self.navigationController
	}
	var containerViewController: UIViewController {
		return self.navigationController
	}
	
	private var navigationController: UINavigationController
	private var topNavigationController: UINavigationController {
		get {
			var viewController = self.navigationController
			while viewController.presentedViewController != nil && (viewController.presentedViewController?.isKind(of: UINavigationController.self))! {
				viewController = viewController.presentedViewController as! UINavigationController
			}
			return viewController
		}
	}
	
	// MARK: BasicNavigationService
	
	func setupWithNavigationController(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: NavigationService
	
	func setViewControllers(viewControllers: [UIViewController], animated: Bool) {
		self.topNavigationController.setViewControllers(viewControllers, animated: animated)
	}
	
	func pushViewController(viewController: UIViewController, animated: Bool) {
		self.topNavigationController.pushViewController(viewController, animated: animated)
	}
	
	func popViewController(animated: Bool) {
		self.topNavigationController.popViewController(animated: animated)
	}
	
	func popToViewController(viewController: UIViewController, animated: Bool) {
		self.topNavigationController.popToViewController(viewController, animated: animated)
	}
	
	func popToRootViewController(animated: Bool) {
		self.topNavigationController.popToRootViewController(animated: animated)
	}
	
	func popToViewControllerOfType<T>(vcType: T.Type, animated: Bool) where T : UIViewController {
		self.topNavigationController.popToViewControllerOfType(vcType: vcType, animated: animated)
	}
	
	// MARK:
	
	func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
		self.topViewController!.present(viewController, animated: animated, completion: completion)
	}
	
	func dismissViewControllerAnimated(animated: Bool, completion: (() -> Void)?) {
		self.topViewController!.dismiss(animated: animated, completion: completion)
	}
	
	// MARK:
	
	func showViewController(viewController: UIViewController, sender: AnyObject?) {
		self.topNavigationController.show(viewController, sender: sender)
	}
	
	func showDetailViewController(viewController: UIViewController, sender: AnyObject?) {
		self.topNavigationController.showDetailViewController(viewController, sender: sender)
	}
}

extension UINavigationController {
	// Pop to the VC of the given class
	// If not found, pop to root
	func popToViewControllerOfType<T: UIViewController>(vcType: T.Type, animated: Bool) {
		let vcArr = self.viewControllers
		for vc in vcArr as Array<AnyObject> {
			if vc is T {
				self.popToViewController(vc as! UIViewController, animated: true)
				return
			}
		}
		
		popToRootViewController(animated: true)
	}
}

