//
//  NetUserUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

final class NetUserUseCase: UserUseCase {
	private let network: UserNetwork
	
	init(network: UserNetwork) {
		self.network = network
	}
	
	// GET
	func userInfo(input: InNWUserInfo) -> OutNWUserData {
		return network.userInfo(input: input)
	}
	
	// Recover password
	func requestPINCode(input: InNWUserInputPinCode) -> OutNWUserVoid {
		return network.requestPINCode(input: input)
	}
	
	func resetPassword(input: InNWUserResetPassword) -> OutNWUserVoid {
		return network.resetPassword(input: input)
	}
	
	// POST
	func register(input: InNWUserRegister) -> OutNWUserData {
		return network.register(input: input)
	}
	
	// PUT
	func update(input: InNWUserUpdate) -> OutNWUserData {
		return network.update(input: input)
	}
	
	func changePassword(input: InNWUserChangePassword) -> OutNWUserData {
		return network.changePassword(input: input)
	}
}
