//
//  NetworkProvider.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

final class NetworkProvider {
	func makeAuthNetwork() -> AuthNetwork {
		return AuthNetwork.init()
	}
	
	func makeUserNetwork() -> UserNetwork {
		return UserNetwork.init()
	}
}
