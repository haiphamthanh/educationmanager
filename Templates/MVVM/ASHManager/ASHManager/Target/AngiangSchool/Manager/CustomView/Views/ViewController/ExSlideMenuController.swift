//
//  ExSlideMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/11/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {
	fileprivate(set) var slideNavigation: UINavigationController?
	
	convenience init(mainVC: UIViewController, leftMenuVC: UIViewController, rightMenuVC: UIViewController) {
		let nvc: UINavigationController = UINavigationController(rootViewController: mainVC)
		self.init(mainViewController: nvc, leftMenuViewController: leftMenuVC, rightMenuViewController: rightMenuVC)
		
		self.delegate = mainVC as? SlideMenuControllerDelegate
		self.slideNavigation = nvc
	}
	
	// MARK: - ================================= Overrided =================================
	override func isTagetViewController() -> Bool {
		return true
	}
	
	override func track(_ trackAction: TrackAction) {
		switch trackAction {
		case .leftTapOpen:
			print("TrackAction: left tap open.")
		case .leftTapClose:
			print("TrackAction: left tap close.")
		case .leftFlickOpen:
			print("TrackAction: left flick open.")
		case .leftFlickClose:
			print("TrackAction: left flick close.")
		case .rightTapOpen:
			print("TrackAction: right tap open.")
		case .rightTapClose:
			print("TrackAction: right tap close.")
		case .rightFlickOpen:
			print("TrackAction: right flick open.")
		case .rightFlickClose:
			print("TrackAction: right flick close.")
		}
	}
}

extension SlideMenuController {
	func pushVC(_ vc: BaseViewController) {
		if let currentSlide = self as? ExSlideMenuController {
			currentSlide.slideNavigation?.pushViewController(vc, animated: true)
			currentSlide.closeAllMenu()
		}
	}
	
	func closeAllMenu() {
		self.closeLeft()
		self.closeRight()
	}
}
