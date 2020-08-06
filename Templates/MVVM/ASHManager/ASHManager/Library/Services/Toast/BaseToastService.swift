//
//  BaseToastService.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Toast_Swift

class BaseToastService {
	private let navigationService: BasicNavigationServiceProtocol
	init(navigationService: BasicNavigationServiceProtocol) {
		self.navigationService = navigationService
	}
}

extension BaseToastService: ToastServiceProtocol {
	// MARK: - ================================= Usage =================================
	func show(message: String) {
		if let nav = self.navigationService.topViewController?.navigationController {
			nav.view.makeToast(message)
			return
		}
		
		self.navigationService.topViewController?.view.makeToast(message)
	}
	
	func show(message: String, type: ToastType) {
		// TODO: implement later
	}
	
	func show(message: String, type: ToastType, position: ToastPosition) {
		// TODO: implement later
	}
}
