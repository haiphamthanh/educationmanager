//
//  PostsUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

/**
Provide methods using for User action
*/
protocol UserUseCase {
	// Info
	func userInfo(input: InNWUserInfo) -> OutNWUserData
	
	// Recover
	func requestPINCode(input: InNWUserInputPinCode) -> OutNWUserVoid
	func resetPassword(input: InNWUserResetPassword) -> OutNWUserVoid
	
	// Register
	func register(input: InNWUserRegister) -> OutNWUserData
	
	// Update
	func update(input: InNWUserUpdate) -> OutNWUserData
	func changePassword(input: InNWUserChangePassword) -> OutNWUserData
}
