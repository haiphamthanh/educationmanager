//
//  SideMenuManager.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/21/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

enum SideMenuType: Int {
	case home = 0
	case userInfo
}

//prefix func !(value: SideMenuType) -> SideMenuType {
//	switch value {
//	case .Home:
//		return .UserProfile
//	case .UserProfile:
//		return .Home
//	}
//}

class SideMenuManager {
	// MARK: - ================================= Properties =================================
	private let pSelected = PublishSubject<(index: SideMenuType, point: CGPoint)>()
	private var currentIndex: SideMenuType!
	private var transitionPoint: CGPoint!
	private weak var menu: MenuViewController!
	private weak var presentView: ViewControllerAdapterSideMenu!
	
	// MARK: - ================================= Init =================================
	init(presentView: ViewControllerAdapterSideMenu, type: SideMenuType) {
		self.presentView = presentView
		self.currentIndex = type
	}
}

extension SideMenuManager {
	var selected: Observable<(index: SideMenuType, point: CGPoint)> {
		return pSelected
	}
	
	func showMenu() {
		menu = MenuViewController.newInstance()
		menu.selectedItem = currentIndex.rawValue
		menu.delegate = self
		menu.transitioningDelegate = presentView
		menu.modalPresentationStyle = .custom
		
		presentView.present(menu, animated: true, completion: nil)
	}
}

extension SideMenuManager: MenuViewControllerDelegate {
	func menu(_: MenuViewController, didSelectItemAt index: Int, at point: CGPoint) {
		let menuType = SideMenuType(rawValue: index) ?? .userInfo
		let selectedItem = (index: menuType, point: point)
		
		pSelected.onNext(selectedItem)
		print("\(self) did selected \(selectedItem)")
		
		DispatchQueue.main.async {
			self.menu.dismiss(animated: true, completion: nil)
		}
	}
	
	func menuDidCancel(_: MenuViewController) {
		menu.dismiss(animated: true, completion: nil)
	}
}

// MARK: - ================================= Private =================================
private extension SideMenuManager {
}

