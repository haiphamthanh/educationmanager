//
//  NetAuthUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

final class NetAuthUseCase: AuthUseCase {
	private let network: AuthNetwork
	init(network: AuthNetwork) {
		self.network = network
	}
	
	// GET
	// POST
	func signIn(input: InNWSignIn) -> OutNWUserData {
		return network.signIn(input: input)
	}
	
	// MARK: Social Network =================================
	func signInByFacebook(input: InNWSignInByFacebook) -> OutNWUserData {
		return network.signInByFacebook(input: input)
	}
	
	func signInByGoogle(input: InNWSignInByGoogle) -> OutNWUserData {
		return network.signInByGoogle(input: input)
	}
	
	// PUT
	// DELETE -> Destroys session
	func signOut(input: InNWSignOut) -> OutNWUserVoid {
		return network.signOut(input: input)
	}
}
