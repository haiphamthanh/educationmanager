//
//  AuthNetwork.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import Moya

// MARK: - ================================= Path =================================
fileprivate let PATH_AUTH_LOGIN = "/login"
fileprivate let PATH_AUTH_LOGOUT = "/logout"
fileprivate let PATH_AUTH_LOGIN_FACEBOOK = "/login_facebook"
fileprivate let PATH_AUTH_LOGIN_GOOGLE = "/login_google"
fileprivate let PATH_AUTH_RESETPASS = "/user/active_password"
fileprivate let PATH_AUTH_REQUEST_PINCODE = "/user/forgot_password"
fileprivate let PATH_AUTH_CHANGE_PASS = "/user/password"
fileprivate let PATH_AUTH_REFRESH_TOKEN = "/user/new_token"

final class AuthNetwork: BaseAPINetwork {
	private let networkVoid = Network<VoidObject, AuthAPI>()
	private let network = Network<AuthEntry, AuthAPI>()
	private let networkSocial = Network<SocialDataEntry, AuthAPI>()
	
	func login(userName: String, passwd: String) -> Observable<AuthData> {
		let result: Observable<AuthEntry> = network.requestRx(api: .login(userName, passwd))
		
		return Observable.create({ observer -> Disposable in
			result.map({ auth -> AuthData in
				return auth.toData()
			}).bind(to: observer)
		})
	}
	
	func loginFacebook(token: String) -> Observable<AuthData> {
		let result: Observable<SocialDataEntry> = networkSocial.requestRx(api: .loginFacebook(token))
		return Observable.create({ observer -> Disposable in
			result.map({ auth -> AuthData in
				return auth.toData()
			}).bind(to: observer)
		})
	}
	
	func loginGoogle(token: String) -> Observable<AuthData> {
		let result: Observable<SocialDataEntry> = networkSocial.requestRx(api: .loginGoogle(token))
		return Observable.create({ observer -> Disposable in
			result.map({ auth -> AuthData in
				return auth.toData()
			}).bind(to: observer)
		})
	}
	
	func requestPINCode(email: String) -> Observable<Void> {
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .requestResetPasswordCode(email))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
	
	func resetPassword(from resetCode: String, newPassword: String) -> Observable<Void> {
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .resetPassword(resetCode, newPassword))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
	
	func changePassword(from oldPassword: String, to newPassword: String) -> Observable<Void> {
		guard let token = token else {
			return Observable.never()
		}
		
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .changePassword(token, oldPassword, newPassword))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
	
	func refreshToken(token: String) -> Observable<AuthEntry> {
		return network.requestRx(api: .refreshToken(token))
	}
	
	func signOut() -> Observable<Void> {
		guard let token = token else {
			return Observable.never()
		}
		
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .signOut(token))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
}

enum AuthAPI {
	case login(String, String)
	case loginFacebook(String)
	case loginGoogle(String)
	case requestResetPasswordCode(String)
	case resetPassword(String, String)
	case changePassword(String, String, String)
	case refreshToken(String)
	case signOut(String)
}

extension AuthAPI: TargetType {
	
	var baseURL: URL {
		return URL(string: ServerInfo.DATA_SERVER_ROOT_URL)!
	}
	
	var path: String {
		switch self {
		case .login:
			return PATH_AUTH_LOGIN
		case .loginFacebook:
			return PATH_AUTH_LOGIN_FACEBOOK
		case .loginGoogle:
			return PATH_AUTH_LOGIN_GOOGLE
		case.requestResetPasswordCode:
			return PATH_AUTH_REQUEST_PINCODE
		case .resetPassword:
			return PATH_AUTH_RESETPASS
		case .changePassword:
			return PATH_AUTH_CHANGE_PASS
		case .refreshToken:
			return PATH_AUTH_REFRESH_TOKEN
		case .signOut:
			return PATH_AUTH_LOGOUT
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .login,
			 .resetPassword,
			 .requestResetPasswordCode,
			 .changePassword,
			 .loginFacebook,
			 .loginGoogle,
			 .refreshToken,
			 .signOut:
			return .post
		}
	}
	
	var sampleData: Data {
		return "{}".data(using: .utf8)!
	}
	
	var task: Task {
		switch self {
		case .login(let username, let password):
			if (Validate.isValidEmail(email: username) == nil) {
				return .requestParameters(parameters: ["email": username,
													   "password": password,
													   "type": "app"],
										  encoding: URLEncoding.default)
			} else {
				return .requestParameters(parameters: ["username": username,
													   "password": password,
													   "type": "app"],
										  encoding: URLEncoding.default)
			}
		case .loginFacebook(let token):
			return .requestParameters(parameters: ["type":"app", "exchange_token" : token],
									  encoding: URLEncoding.default)
		case .loginGoogle(let token):
			return .requestParameters(parameters: ["type": AppInfo.APP_TYPE,
												   "code": "defaults",
												   "access_token": token],
									  encoding: URLEncoding.default)
		case .requestResetPasswordCode(let email):
			return .requestParameters(parameters: ["email": email],
									  encoding: URLEncoding.default)
		case .resetPassword(let resetCode, let newPassword):
			return .requestParameters(parameters: ["code": resetCode, "password": newPassword],
									  encoding: URLEncoding.default)
		case .changePassword(let token, let oldPassword, let newPassword):
			return .requestParameters(parameters: ["token": token, "current_password": oldPassword, "password": newPassword],
									  encoding: URLEncoding.default)
		case .refreshToken(let rfToken):
			return .requestParameters(parameters: ["refresh_token": rfToken],
									  encoding: URLEncoding.default)
		case .signOut(let token):
			return .requestParameters(parameters: ["token": token],
									  encoding: URLEncoding.default)
		}
	}
	
	var validate: Bool {
		switch self {
		case .login(let username, let password):
			return isValidLength(username: username, password: password)
		case .loginFacebook(_):
			return true
		case .loginGoogle(_):
			return true
		case .requestResetPasswordCode(let email):
			return Validate.isValidEmail(email: email) == nil
		case .resetPassword(let pinCode, let newPassword):
			return Validate.isValidInputEmpty(inputString: pinCode) == nil
				&& Validate.isValidInputEmpty(inputString: newPassword) == nil
				&& Validate.isValidAuthInputLength(inputString: pinCode) == nil
				&& Validate.isValidAuthInputLength(inputString: newPassword) == nil
		case .changePassword(let token, let oldPassword, let newPassword):
			return Validate.isValidInputEmpty(inputString: token) == nil
				&& Validate.isValidInputEmpty(inputString: oldPassword) == nil
				&& Validate.isValidInputEmpty(inputString: newPassword) == nil
				&& Validate.isValidAuthInputLength(inputString: oldPassword) == nil
				&& Validate.isValidAuthInputLength(inputString: newPassword) == nil
		case .refreshToken, .signOut:
			return true
		}
	}
	
	var headers: [String : String]? {
		return ServerInfo.HEADER_SERVER_PARAMS
	}
	
	private func isValidLength(username: String, password: String) -> Bool {
		return (Validate.isValidAuthInputLength(inputString: username) != nil)
			&& (Validate.isValidAuthInputLength(inputString: password) != nil)
	}
}
