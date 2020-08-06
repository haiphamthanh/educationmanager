//
//  HomeViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

class HomeViewController: HomeBaseViewController {
	// MARK: - ================================= Outlet =================================
	
	// MARK: - ================================= Properties =================================
	
	// MARK: - ================================= Init =================================
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.titleHome()
	}
}

// MARK: - ================================= Final =================================
extension HomeViewController : HomeViewProtocol {
}

// MARK: - ================================= Extension =================================
private extension HomeViewController {
	var viewModel: HomeViewModelProtocol {
		return viewModelWraper(type: HomeViewModelProtocol.self)
	}
}
