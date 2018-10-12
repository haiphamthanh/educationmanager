//
//  AuthService.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

class AuthService: BaseAuthService {
	
	// MARK: - ================================= Overrided =================================
	override func authProviders() -> [AuthItem] {
		return [AuthItem(type: .Facebook, appKey: "", token: "")]
	}
	
	func homeViewController() -> HomeViewController {
		return HomeViewController.newInstance()
	}
}
