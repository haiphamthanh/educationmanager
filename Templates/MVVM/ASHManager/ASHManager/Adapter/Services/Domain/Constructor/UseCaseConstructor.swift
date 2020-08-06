//
//  UseCaseConstructor.swift
//  ASEducation
//
//  Created by 7i3u7u on 11/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class UseCaseConstructor {
	private var useCaseProvider: UseCaseProviderProtocol
	
	// MARK: - ================================= Init =================================
	init(useCaseProvider: UseCaseProviderProtocol) {
		self.useCaseProvider = useCaseProvider
	}
}

// MARK: - ================================= UseCasesProtocol =================================
extension UseCaseConstructor: UseCasesProtocol {
}


// MARK: - ================================= OAuth =================================
extension UseCaseConstructor {
	// Sign in
	func signIn(input: InNWSignIn) -> OutNWUserData {
		return useCaseProvider.makeAuthUseCase().signIn(input: input)
	}
	func signInByFacebook(input: InNWSignInByFacebook) -> OutNWUserData {
		return useCaseProvider.makeAuthUseCase().signInByFacebook(input: input)
	}
	func signInByGoogle(input: InNWSignInByGoogle) -> OutNWUserData {
		return useCaseProvider.makeAuthUseCase().signInByGoogle(input: input)
	}
	
	// Sign out
	func signOut(input: InNWSignOut) -> OutNWUserVoid {
		return useCaseProvider.makeAuthUseCase().signOut(input: input)
	}
}

// MARK: - ================================= User =================================
extension UseCaseConstructor {
	// Info
	func userInfo(input: InNWUserInfo) -> OutNWUserData {
		return useCaseProvider.makeUserUseCase().userInfo(input: input)
	}
	
	// Recover
	func requestPINCode(input: InNWUserInputPinCode) -> OutNWUserVoid {
		return useCaseProvider.makeUserUseCase().requestPINCode(input: input)
	}
	
	func resetPassword(input: InNWUserResetPassword) -> OutNWUserVoid {
		return useCaseProvider.makeUserUseCase().resetPassword(input: input)
	}
	
	// Register
	func register(input: InNWUserRegister) -> OutNWUserData {
		return useCaseProvider.makeUserUseCase().register(input: input)
	}
	
	// Update
	func update(input: InNWUserUpdate) -> OutNWUserData {
		return useCaseProvider.makeUserUseCase().update(input: input)
	}
	
	func changePassword(input: InNWUserChangePassword) -> OutNWUserData {
		return useCaseProvider.makeUserUseCase().changePassword(input: input)
	}
}
