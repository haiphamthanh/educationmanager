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
// C
// R
fileprivate let PATH_AUTH_SIGNIN = "/signin"
fileprivate let PATH_AUTH_SIGNIN_FACEBOOK = "/signin_facebook"
fileprivate let PATH_AUTH_SIGNIN_GOOGLE = "/signin_google"
fileprivate let PATH_AUTH_REFRESH_TOKEN = "/user/new_token"
// U
// D
fileprivate let PATH_AUTH_SIGNOUT = "/signout"

// MARK: - ================================= Params =================================
// Input
typealias InNWSignIn = (username: String, passwd: String)
typealias InNWSignInByFacebook = (String)
typealias InNWSignInByGoogle = (String)
typealias InNWRefreshNewToken = (String)
typealias InNWSignOut = (Void)

// MARK: - ================================= API Implement =================================
final class AuthNetwork: BaseAPINetwork {
	private lazy var networking = Networking<AuthAPI, UserEntry>()
	private lazy var networkingVoid = Networking<AuthAPI, VoidEntry>()
	
	// GET
	// POST -> Creates session
	func signIn(input: InNWSignIn) -> OutNWUserData {
		let api: AuthAPI = .signIn(username: input.username, passwd: input.passwd)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	// MARK: Social Network =================================
	func signInByFacebook(input: InNWSignInByFacebook) -> OutNWUserData {
		let api: AuthAPI = .signInByFacebook(input)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	func signInByGoogle(input: InNWSignInByGoogle) -> OutNWUserData {
		let api: AuthAPI = .signInByGoogle(input)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	func refreshNewToken(input: InNWRefreshNewToken) -> OutNWNewToken {
		let api: AuthAPI = .refreshToken(input)
		
		let result = networking
			.request(id: id, api)
			.map(didRefreshNewToken)
		
		//			.filterSuccessfulStatusCodes()
		//			.mapJSON()
		//			.map { element -> (token: String?, expiry: String?) in
		//				guard let dictionary = element as? NSDictionary else { return (token: nil, expiry: nil) }
		//
		//				return (token: dictionary["xapp_token"] as? String, expiry: dictionary["expires_in"] as? String)
		//			}
		//			.do(onNext: { element in
		//				// These two lines set the defaults values injected into appToken
		//				appToken.token = element.0
		//				appToken.expiry = KioskDateFormatter.fromString(element.1 ?? "")
		//			})
		//			.map { (token, expiry) -> String? in
		//				return token
		//			}
		//			.logError()
		
		return OutNWNewToken(id, result)
	}
	
	// PUT
	// DELETE -> Destroys session
	func signOut(input: InNWSignOut) -> OutNWUserVoid {
		let api: AuthAPI = .signOut
		
		let result = networkingVoid
			.request(id: id, api)
			.map(transformToVoid)
		
		return OutNWUserVoid(id, result)
	}
	
	// Sign in completion keep token
	private func transformToData(_ user: UserEntry) -> UserData {
		let userData = user.asData()
		return didSignIn(user: userData)
	}
	
	private func didRefreshNewToken(_ user: UserEntry) -> String {
		let userData = transformToData(user)
		return userData.userInfo.token
	}
}

enum AuthAPI {
	// Get
	// Post
	case signIn(username: String, passwd: String)
	case signInByFacebook(String)
	case signInByGoogle(String)
	case refreshToken(String)
	// Put
	// Delete
	case signOut
}

extension AuthAPI: TargetType, APIType {
	var baseURL: URL {
		return URL(string: Server.shared.root)!
	}
	
	var path: String {
		switch self {
		case .signIn:
			return PATH_AUTH_SIGNIN
		case .signInByFacebook:
			return PATH_AUTH_SIGNIN_FACEBOOK
		case .signInByGoogle:
			return PATH_AUTH_SIGNIN_GOOGLE
		case .refreshToken:
			return PATH_AUTH_REFRESH_TOKEN
		case .signOut:
			return PATH_AUTH_SIGNOUT
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .signIn,
			 .signInByFacebook,
			 .signInByGoogle,
			 .refreshToken:
			return .post
		case .signOut:
			return .delete
		}
	}
	
	var task: Task {
		switch self {
		case .signIn(let username, let password):
			return .requestParameters(parameters: ["username": username,
												   "password": password],
									  encoding: URLEncoding.default)
		case .signInByFacebook(let facebookToken):
			return .requestParameters(parameters: ["facebookToken" : facebookToken],
									  encoding: URLEncoding.default)
		case .signInByGoogle(let googleToken):
			return .requestParameters(parameters: ["googleToken" : googleToken],
									  encoding: URLEncoding.default)
		case .refreshToken(let refreshToken):
			return .requestParameters(parameters: ["refreshToken" : refreshToken],
									  encoding: URLEncoding.default)
		case .signOut:
			return .requestPlain
		}
	}
	
	var validate: Bool {
		return true
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var sampleData: Data {
		return stubbedResponse("User")
	}
	
	var addXAccess: Bool {
		return false
	}
}
