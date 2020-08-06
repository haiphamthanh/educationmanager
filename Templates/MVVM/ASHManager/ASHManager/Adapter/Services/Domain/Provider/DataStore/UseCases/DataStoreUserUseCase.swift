//
//  NetUserUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

final class DataStoreUserUseCase: UserUseCase {
	private let dataStore: UserDataStore
	
	init(dataStore: UserDataStore) {
		self.dataStore = dataStore
	}
	
	// GET
	func userInfo(input: InNWUserInfo) -> OutNWUserData {
		return dataStore.userInfo(input: input)
	}
	
	// Recover password
	func requestPINCode(input: InNWUserInputPinCode) -> OutNWUserVoid {
		fatalError("Don't support local")
	}
	
	func resetPassword(input: InNWUserResetPassword) -> OutNWUserVoid {
		fatalError("Don't support local")
	}
	
	// POST
	func register(input: InNWUserRegister) -> OutNWUserData {
		fatalError("Don't support local")
	}
	
	// PUT
	func update(input: InNWUserUpdate) -> OutNWUserData {
		return dataStore.update(input: input)
	}
	
	func changePassword(input: InNWUserChangePassword) -> OutNWUserData {
		fatalError("Don't support local")
	}
}
