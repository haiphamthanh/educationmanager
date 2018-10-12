//
//  AuthServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit.UIViewController

enum AuthType : Int {
	case Facebook = 0
	case Google
	case Twitter
	case Phone
}

struct AuthItem {
	var type: AuthType
	var appKey: String
	var token: String
}

protocol AuthServiceProtocol {
	func authProviders() -> [AuthItem]
	func isAuthorized() -> Bool
	func loginViewController() -> AuthViewController
	func rootViewController() -> UIViewController
}
