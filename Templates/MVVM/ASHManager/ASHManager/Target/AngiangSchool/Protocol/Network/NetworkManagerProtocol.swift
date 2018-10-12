//
//  NetworkManagerProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/27/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol NetworkManagerProtocol : NetworkServiceProtocol {
	
	// MARK: - ================================= Auth =================================
	func login(userName: String, password: String) -> Observable<Void>
	func signOut() -> Observable<Void>
	
	// MARK: - ================================= User =================================
	func register(user: UserData) -> Observable<Void>
	func update(user: UserData) -> Observable<Void>
	func update(password: String, for userName: String) -> Observable<Void>
	func requestResetPasswordCode(by email: String) -> Observable<Void>
	func resetPassword(from resetCode: String, newPassword: String) -> Observable<Void>
	func changePassword(from oldPassword: String, to newPassword: String) -> Observable<Void>
	func fetchUserDetail() -> Observable<UserData>
	
	// MARK: - ================================= Gobe =================================
	func fetchGobeUserInfo(userName: String, password: String) -> Observable<UserData>
	
	// MARK: - ================================= Fitbit =================================
	func fetchFitbitUserInfo(from code: String) -> Observable<UserData>
	
	// MARK: - ================================= Social Network =================================
	func loginFacebook(token: String) -> Observable<Void>
	func loginGoogle(token: String) -> Observable<Void>
}
