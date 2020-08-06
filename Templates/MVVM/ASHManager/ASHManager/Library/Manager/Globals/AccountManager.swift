//
//  AccountManager.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol AccountManagerProtocol {
	// Need config for first app loaded
	func config(viewmodel: AccountManagerViewModel)
	
	var needSignInAgain: Bool { get }
	var isUserAvailble: Bool { get }
	
	func signInInfo() -> (isSigned: Bool, user: UserData?)
	func bringMeNewUserInfo() -> Observable<UserData>
}

class AccountManager {
	// MARK: - ================================= Properties =================================
	class var shared: AccountManager {
		struct Static {
			static let instance = AccountManager()
		}
		
		return Static.instance
	}
	
	// MARK: Account checking =================================
	private let tokenInfo = XAccessToken()
	private var viewmodel: AccountManagerViewModel!
	private let disposeBag = DisposeBag()
	
	// MARK: Account info =================================
	private var user: UserData?
}

extension AccountManager: AccountManagerProtocol {
}

// MARK: Usage info =================================
extension AccountManager {
	// Need config for first app loaded
	func config(viewmodel: AccountManagerViewModel) {
		self.viewmodel = viewmodel
	}
	
	var needSignInAgain: Bool {
		return !tokenInfo.isValid
	}
	
	var isUserAvailble: Bool {
		return tokenInfo.token != nil
	}
	
	func signInInfo() -> (isSigned: Bool, user: UserData?) {
		return (isSigned: tokenInfo.isValid, user: user)
	}
	
	func bringMeNewUserInfo() -> Observable<UserData> {
		return viewmodel
			.reloadUser()
			.take(1)
			.do(onNext: { newUser in
				self.user = newUser
			})
	}
}

// MARK: View model =================================
class AccountManagerViewModel: BaseViewModel {
	fileprivate func reloadUser() -> Observable<UserData> {
		let input: Void = InNWUserInfo()
		let out = network.userInfo(input: input)
		
		let _ = out.requestId
		let result = out.result
		
		return result
			.map({ InNWUserUpdate($0, nil, "") })
			.flatMap(saveLocal)
	}
	
	private func saveLocal(input: InNWUserUpdate) -> Observable<UserData> {
		return dataStore
			.update(input: input)
			.result
	}
}
