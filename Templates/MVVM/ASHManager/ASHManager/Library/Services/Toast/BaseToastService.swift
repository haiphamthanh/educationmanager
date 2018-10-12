//
//  BaseToastService.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Toast_Swift

class BaseToastService {
	private var navigationService: BasicNavigationServiceProtocol!
}

extension BaseToastService: ToastServiceProtocol {
	// MARK: - ================================= Init =================================
	func use(navigationService: BasicNavigationServiceProtocol) {
		self.navigationService = navigationService
	}
	
	// MARK: - ================================= Usage =================================
	func toast(message: String) {
		if let nav = self.navigationService?.topViewController?.navigationController {
			nav.view.makeToast(message)
			return
		}
		
		self.navigationService?.topViewController?.view.makeToast(message)
	}
	
	func toast(message: String, type: ToastType) {
		// TODO: implement later
	}
	
	func toast(message: String, type: ToastType, position: ToastPosition) {
		// TODO: implement later
	}
}
