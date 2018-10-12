//
//  NetworkManager.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/27/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class NetworkManager: BaseNetworkService, NetworkManagerProtocol {
	
	private var netUseCaseProvider: UseCaseProviderProtocol
	
	// MARK: - ================================= Init =================================
	init(netUseCaseProvider: UseCaseProviderProtocol) {
		self.netUseCaseProvider = netUseCaseProvider
	}
	
	// MARK: - ================================= Auth =================================
	func login(userName: String, password: String) -> Observable<Void> {
		let result: Observable<AuthData> = netUseCaseProvider.makeAuthUseCase().login(userName: userName, passwd: password)
		
		return Observable.create({ observer -> Disposable in
			result.map({ [unowned self] auth -> Void in
				self.keep(token: auth.token, roleId: auth.role_id)
				self.keep(refreshToken: auth.refreshToken)
			}).bind(to: observer)
		})
	}
	
	func signOut() -> Observable<Void> {
		return netUseCaseProvider.makeAuthUseCase().signOut()
	}
	
	// MARK: - ================================= User =================================
	func register(user: UserData) -> Observable<Void> {
		if user.userInfo.id > -1 {
			let result = update(user: user)
			return result
		}
		
		let result: Observable<AuthData> = netUseCaseProvider.makeUserUseCase().register(user: user)
		return Observable.create({ observer -> Disposable in
			result.map({ [unowned self] auth -> Void in
				self.keep(token: auth.token, roleId: auth.role_id)
				self.keep(refreshToken: auth.refreshToken)
			}).bind(to: observer)
		})
	}
	
	func update(user: UserData) -> Observable<Void> {
		return netUseCaseProvider.makeUserUseCase().update(user: user)
	}
	
	func update(password: String, for userName: String) -> Observable<Void> {
		return netUseCaseProvider.makeUserUseCase().change(password:password, of:userName)
	}
	
	func requestResetPasswordCode(by email: String) -> Observable<Void> {
		return netUseCaseProvider.makeAuthUseCase().requestPINCode(byEmail: email)
	}
	
	func resetPassword(from resetCode: String, newPassword: String) -> Observable<Void> {
		return netUseCaseProvider.makeAuthUseCase().resetPassword(from: resetCode, newPassword: newPassword)
	}
	
	func changePassword(from oldPassword: String, to newPassword: String) -> Observable<Void> {
		return netUseCaseProvider.makeAuthUseCase().changePassword(from: oldPassword, to: newPassword)
	}
	
	func fetchUserDetail() -> Observable<UserData> {
		return netUseCaseProvider.makeUserUseCase().userDetail()
	}
	
	// MARK: - ================================= Gobe =================================
	func fetchGobeUserInfo(userName: String, password: String) -> Observable<UserData> {
		return netUseCaseProvider.makeDeviceUseCase().gobeProfile(userName: userName, password: password)
	}
	
	// MARK: - ================================= Fitbit =================================
	func fetchFitbitUserInfo(from code: String) -> Observable<UserData> {
		return netUseCaseProvider.makeDeviceUseCase().fitbitProfile(from: code)
	}
	
	// MARK: - ================================= Social Network =================================
	func loginFacebook(token: String) -> Observable<Void> {
		let result: Observable<AuthData> = netUseCaseProvider.makeAuthUseCase().loginFacebook(token: token)
		return Observable.create({ observer -> Disposable in
			result.map({ [unowned self] auth -> Void in
				self.keep(token: auth.token, roleId: auth.role_id)
				self.keep(refreshToken: auth.refreshToken)
			}).bind(to: observer)
		})
	}
	
	func loginGoogle(token: String) -> Observable<Void> {
		let result: Observable<AuthData> = netUseCaseProvider.makeAuthUseCase().loginGoogle(token: token)
		return Observable.create({ observer -> Disposable in
			result.map({ [unowned self] auth -> Void in
				self.keep(token: auth.token, roleId: auth.role_id)
				self.keep(refreshToken: auth.refreshToken)
			}).bind(to: observer)
		})
	}
	
	// MARK: - ================================= Private =================================
	private func keep(token: String, roleId: Int) {
		Config.keep(token: token, roleId: roleId)
	}
	
	private func keep(refreshToken: String) {
		Config.keep(refreshToken: refreshToken)
	}
}
