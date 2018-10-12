//
//  NavigationServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/2/17.
//  Copyright © 2017 Asahi. All rights reserved.
//  Referrences: https://github.com/AttilaTheFun/NavigationService
//

import UIKit.UINavigationController

protocol NavigationServiceProtocol {
	// MARK: Properties
	
	// The visible view controller is either the top of the navigation stack or a view controller
	// being presented modally by it.
	var visibleViewController: UIViewController? { get }
	// The view controller at the top of the navigation stack.
	var topViewController: UIViewController? { get }
	// The view controllers in the selected navigation controller's stack.
	var viewControllers: [UIViewController] { get }
	// The currently selected navigation controller. (There may only be one.)
	var selectedNavigationController: UINavigationController { get }
	// The container view controller housing all of the other view controllers.
	var containerViewController: UIViewController { get }
	
	// MARK: General
	
	func showViewController(viewController: UIViewController, sender: AnyObject?)
	func showDetailViewController(viewController: UIViewController, sender: AnyObject?)
	
	// MARK: Stack
	
	// Sets the view controllers on the selected navigation controller's stack.
	func setViewControllers(viewControllers: [UIViewController], animated: Bool)
	func pushViewController(viewController: UIViewController, animated: Bool)
	// Pops the top view controller from the selected navigation controller's stack.
	func popViewController(animated: Bool)
	func popToViewController(viewController: UIViewController, animated: Bool)
	func popToViewControllerOfType<T: UIViewController>(vcType: T.Type, animated: Bool)
	func popToRootViewController(animated: Bool)
	
	// MARK: Modal
	
	func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
	func dismissViewControllerAnimated(animated: Bool, completion: (() -> Void)?)
}

protocol BasicNavigationServiceProtocol: NavigationServiceProtocol {
	func setupWithNavigationController(navigationController: UINavigationController)
}

protocol SplitNavigationServiceProtocol: NavigationServiceProtocol {
	func setupWithSplitViewController(splitViewController: UISplitViewController)
}

protocol TabbedNavigationServiceProtocol: NavigationServiceProtocol {
	var rootNavigationControllers: [UINavigationController] { get }
	var moreNavigationController: UINavigationController { get }
	
	func setupWithTabBarController(tabBarController: UITabBarController)
	func selectNavigationController(navigationController: UINavigationController)
}
