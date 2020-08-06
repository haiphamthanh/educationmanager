//
//  UseCasesProtocol.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

protocol UseCasesProtocol {
	// MARK: - ================================= OAuth =================================
	// Sign in
	func signIn(input: InNWSignIn) -> OutNWUserData
	func signInByFacebook(input: InNWSignInByFacebook) -> OutNWUserData
	func signInByGoogle(input: InNWSignInByGoogle) -> OutNWUserData
	
	// Sign out
	func signOut(input: InNWSignOut) -> OutNWUserVoid
	
	// MARK: - ================================= User =================================
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

