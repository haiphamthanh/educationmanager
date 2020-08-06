//
//  HomeTabbarManager.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol HomeTabbarManagerProtocol {
	associatedtype T
	func reloadView(with input: T)
}

class HomeTabbarManager {
	private let tabNames = ["Home", "News", "Video"]
}

// Usage list
extension HomeTabbarManager {
	func config(tabbar: UITabBarController, from parent: ViewControllerAdapter, viewModel: HomeViewModelProtocol) {
		guard let vcs = tabbar.viewControllers else {
			return
		}
		
		let numberOfVC = vcs.count
		for i in 0..<numberOfVC {
			guard let tabVC = vcs[i] as? ViewControllerAdapter else {
				return
			}
			
			let icon = parent.image.tabbars[i]
			let tabName = tabNames[i]
			let type = viewModelType(from: tabVC)
			let tabViewModel = viewModel.clone(with: type)
			
			config(tabVC: tabVC,
				   viewModel: tabViewModel,
				   tabName: tabName,
				   icon: icon,
				   from: parent)
		}
	}
}

private extension HomeTabbarManager {
	func viewModelType(from tabVC: ViewControllerAdapter) -> BaseViewModel.Type {
		switch tabVC {
		case is HomeMainViewController:
			return HomeMainViewModel.self
		case is HomeNewsViewController:
			return HomeNewsViewModel.self
		case is HomeVideoViewController:
			return HomeVideoViewModel.self
		default:
			return HomeMainViewModel.self
		}
	}
	
	func config(tabVC: ViewControllerAdapter,
				viewModel: BaseViewModelProtocol,
				tabName: String,
				icon: UIImage,
				from parent: ViewControllerAdapter) {
		// Config view model
		tabVC.initialize(viewModel: viewModel,
						 alert: parent.alert,
						 toast: parent.toast,
						 image: parent.image)
		viewModel.push(params: nil)
		
		// Config tabbar image
		tabVC.tabBarItem.image = icon.withRenderingMode( .alwaysOriginal )
		tabVC.tabBarItem.selectedImage = icon.withRenderingMode( .alwaysOriginal )
		
		// Config tabbar name
		tabVC.title = tabName
	}
}
