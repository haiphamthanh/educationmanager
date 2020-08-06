//
//  AuthUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

/**
Provide methods using for Auth action
*/
protocol AuthUseCase {
	// MARK: Sign in =================================
	func signIn(input: InNWSignIn) -> OutNWUserData
	func signInByFacebook(input: InNWSignInByFacebook) -> OutNWUserData
	func signInByGoogle(input: InNWSignInByGoogle) -> OutNWUserData
	
	// MARK: Sign out =================================
	func signOut(input: InNWSignOut) -> OutNWUserVoid
}
