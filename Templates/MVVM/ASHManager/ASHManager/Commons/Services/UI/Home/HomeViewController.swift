//
//  HomeViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import SlideMenuControllerSwift

class HomeViewController: ViewControllerAdapter {
	override func mainTitle() -> String {
		return LocalizedString.titleHome()
	}
	
	override class func storyNameProvider() -> String {
		return AppStoryboard.home
	}
}

// MARK: - ================================= Final =================================
extension HomeViewController : HomeViewProtocol {
}

// MARK: - ================================= Extension =================================
extension HomeViewController : SlideMenuControllerDelegate {
	
	func leftWillOpen() {
		print("SlideMenuControllerDelegate: leftWillOpen")
	}
	
	func leftDidOpen() {
		print("SlideMenuControllerDelegate: leftDidOpen")
	}
	
	func leftWillClose() {
		print("SlideMenuControllerDelegate: leftWillClose")
	}
	
	func leftDidClose() {
		print("SlideMenuControllerDelegate: leftDidClose")
	}
	
	func rightWillOpen() {
		print("SlideMenuControllerDelegate: rightWillOpen")
	}
	
	func rightDidOpen() {
		print("SlideMenuControllerDelegate: rightDidOpen")
	}
	
	func rightWillClose() {
		print("SlideMenuControllerDelegate: rightWillClose")
	}
	
	func rightDidClose() {
		print("SlideMenuControllerDelegate: rightDidClose")
	}
}

