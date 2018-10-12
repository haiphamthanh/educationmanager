//
//  AuthUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

/**
Provide methods using for Auth action
*/
protocol AuthUseCase {
	func login(userName: String, passwd: String) -> Observable<AuthData>
	func loginFacebook(token: String) -> Observable<AuthData>
	func loginGoogle(token: String) -> Observable<AuthData>
	func requestPINCode(byEmail: String) -> Observable<Void>
	func resetPassword(from resetCode: String, newPassword: String) -> Observable<Void>
	func changePassword(from oldPassword: String, to newPassword: String) -> Observable<Void>
	func signOut() -> Observable<Void>
}
