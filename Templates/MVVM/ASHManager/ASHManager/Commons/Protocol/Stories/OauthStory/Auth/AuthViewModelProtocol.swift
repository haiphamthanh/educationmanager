//
//  AuthViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import GoogleSignIn

enum SocialLogin: Int {
	case email = 0
	case facebook
	case google
	case twitter
	case whatsApp
	case instagram
	case flickr
	case youtube
	case pinterest
}

enum TermAction: Int {
	case termOfUse
	case policy
}

struct GoogleParam {
	let user: GIDGoogleUser
}

struct FacebookParam {
	let token: String
}

struct LoginParams<T> {
	let socialType: SocialLogin
	let param: T
	
	init(param: T) {
		self.param = param
		
		switch self.param {
		case is GoogleParam:
			self.socialType = .google
		case is FacebookParam:
			self.socialType = .facebook
		default:
			self.socialType = .email
		}
	}
}

struct AuthViewData {
	let isAgreeTermOfUse: Bool
}

protocol AuthViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var input: PublishSubject<(userName: String, pass: String, isAgreeTerm: Bool)> { get }
	var readTermOfUse: AnyObserver<TermAction> { get }
	var forgotPassword: AnyObserver<Void> { get }
	func signIn<T>(with param: LoginParams<T>)
	
	// MARK: Coordinator - Outputs
	var isValidResult: Observable<Bool> { get }
	var didSignedIn: Observable<Dictionary<String, Any>?> { get }
	var signUpNew: Observable<Dictionary<String, Any>?> { get }
	var didForgotPassword: Observable<Dictionary<String, Any>?> { get }
	var wannaReadTermOfUse: Observable<Dictionary<String, Any>?> { get }
}
