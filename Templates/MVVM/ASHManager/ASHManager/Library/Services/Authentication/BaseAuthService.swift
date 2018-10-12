//
//  BaseAuthService.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

class BaseAuthService: NSObject, AuthServiceProtocol {
	private(set) weak var container: Container?
	private weak var rootVC: UIViewController?
	private var authVC: AuthViewController?
	
	// MARK: - ================================= Init =================================
	init(container: Container, authenVC: AuthViewController, rootVC: UIViewController) {
		super.init()
		self.container = container
		self.rootVC = rootVC
		self.authVC = authenVC
	}
	
	// MARK: - ================================= Internal =================================
	func authProviders() -> [AuthItem] {
		return []
	}
	
	func isAuthorized() -> Bool {
		return false
	}
	
	func loginViewController() -> AuthViewController {
		return authVC!
	}
	
	func rootViewController() -> UIViewController {
		return rootVC!
	}
}
