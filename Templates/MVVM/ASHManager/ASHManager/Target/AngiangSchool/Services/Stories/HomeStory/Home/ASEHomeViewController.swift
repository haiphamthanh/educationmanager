//
//  ASEHomeViewController.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ########################## Customization ##########################
class ASEHomeViewController: HomeViewController {
	private let homeTabManager = HomeTabbarManager()
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let tabbar = segue.destination as? UITabBarController {
			tabbar.delegate = self
			configViewControllers(tabbar: tabbar)
		}
	}
}

extension ASEHomeViewController: UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		title = viewController.title
	}
}

// MARK: - ================================= Private =================================
private extension ASEHomeViewController {
	var viewModel: HomeViewModelProtocol {
		return viewModelWraper(type: HomeViewModelProtocol.self)
	}
	
	func configViewControllers(tabbar: UITabBarController) {
		// Adater to sub screens
		return homeTabManager.config(tabbar: tabbar, from: self, viewModel: viewModel)
	}
}
