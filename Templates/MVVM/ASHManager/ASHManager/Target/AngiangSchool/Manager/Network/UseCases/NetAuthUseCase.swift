//
//  NetAuthUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

final class NetAuthUseCase: AuthUseCase {

	private let network: AuthNetwork
	
	init(network: AuthNetwork) {
		self.network = network
	}
	
	func login(userName: String, passwd: String) -> Observable<AuthData> {
		return network.login(userName: userName, passwd: passwd)
	}
	
	func loginFacebook(token: String) -> Observable<AuthData> {
		return network.loginFacebook(token: token)
	}
	
	func loginGoogle(token: String) -> Observable<AuthData> {
		return network.loginGoogle(token: token)
	}
	
	func requestPINCode(byEmail: String) -> Observable<Void> {
		return network.requestPINCode(email: byEmail)
	}
	
	func resetPassword(from resetCode: String, newPassword: String) -> Observable<Void> {
		return network.resetPassword(from: resetCode, newPassword: newPassword)
	}
	
	func changePassword(from oldPassword: String, to newPassword: String) -> Observable<Void> {
		return network.changePassword(from: oldPassword, to: newPassword)
	}
	
	func signOut() -> Observable<Void> {
		return network.signOut()
	}
}
