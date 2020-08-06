//
//  ViewControllerAdapterSideMenu.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import SideMenu

private enum SlideMenuType: Int {
	case swipeOnly = 0
	case navigation
	case both
}

// MARK: - ########################## SIDE_MENU ##########################
class ViewControllerAdapterSideMenu: ViewControllerAdapter {
	lazy fileprivate var menuAnimator = MenuTransitionAnimator(mode: .presentation,
															   shouldPassEventsOutsideMenu: false) { [unowned self] in
																self.dismiss(animated: true, completion: nil)
	}
	
	override var isNavBarHidden: Bool {
		return true
	}
	
	/// Use for customization
	override func setupViews() {
		super.setupViews()
		
		setupSlideMenuTask(type: .swipeOnly)
	}
}

// MARK: - ================================= Private =================================
private extension ViewControllerAdapterSideMenu {
	private var viewModel: ViewModelAdapterSideMenuProtocol {
		return viewModelWraper(type: ViewModelAdapterSideMenuProtocol.self)
	}
	
	func setupSlideMenuTask(type: SlideMenuType) {
		switch type {
		case .swipeOnly:
			return setupSlideMenuSwipeOnly()
		case .navigation:
			return setupSlideMenuNavigation()
		case .both:
			return setupSlideMenuBothSwipeAndNavigation()
		}
	}
	
	// Selection choosing
	func setupSlideMenuSwipeOnly() {
		// Left
		view.rx
			.anyGesture(.swipe(direction: .right))
			.when(.recognized)
			.map({ _ in })
			.bind(to: viewModel.showMenu)
			.disposed(by: disposeBag)
	}
	
	func setupSlideMenuNavigation() {
		// Disable navigation bar
		removeNavigationBarItem()
		
		// Create new left and right button
		let barMenuButton = leftRightBarButton()
		
		// Add action for left, right menu
		setupAction(button: barMenuButton)
		
		// Add action for right menu
		return pushToNavigationBar(button: barMenuButton)
	}
	
	func setupSlideMenuBothSwipeAndNavigation() {
		setupSlideMenuSwipeOnly()
		setupSlideMenuNavigation()
	}
	
	// Sub functions
	func removeNavigationBarItem() {
		navigationItem.leftBarButtonItem = nil
		navigationItem.rightBarButtonItem = nil
	}
	
	func leftRightBarButton() -> (left: UIButton, right: UIButton) {
		let leftIcon = image.leftMenuIcon
		let leftButton = UIButton(type: .custom)
		leftButton.setImage(leftIcon, for: .normal)
		leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		
		let rightIcon = image.rightMenuIcon
		let rightButton = UIButton(type: .custom)
		rightButton.setImage(rightIcon, for: .normal)
		rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		
		return (left: leftButton, right: rightButton)
	}
	
	func setupAction(button: (left: UIButton, right: UIButton)) {
		// Left
		button.left.rx
			.tapGesture()
			.when(.recognized)
			.map({ _ in })
			.bind(to: viewModel.showMenu)
			.disposed(by: disposeBag)
		
		// Right
		button.right.rx
			.tapGesture()
			.when(.recognized)
			.map({ _ in })
			.bind(to: viewModel.showMenu)
			.disposed(by: disposeBag)
	}
	
	func pushToNavigationBar(button: (left: UIButton, right: UIButton)) {
		let leftBarButton = UIBarButtonItem(customView: button.left)
		let rightBarButton = UIBarButtonItem(customView: button.right)
		
		navigationItem.setLeftBarButton(leftBarButton, animated: true)
		navigationItem.setRightBarButton(rightBarButton, animated: true)
	}
}

extension ViewControllerAdapterSideMenu: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting _: UIViewController,
							 source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return menuAnimator
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return MenuTransitionAnimator(mode: .dismissal)
	}
}
