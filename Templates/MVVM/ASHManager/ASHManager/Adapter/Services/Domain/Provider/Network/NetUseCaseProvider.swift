//
//  NetUseCaseProvider.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

final class NetUseCaseProvider: NetUseCaseProviderProtocol {
	private let networkProvider: NetworkProvider
	
	init() {
		networkProvider = NetworkProvider()
	}
	
	func makeUserUseCase() -> UserUseCase {
		return NetUserUseCase(network: networkProvider.makeUserNetwork())
	}
	
	func makeAuthUseCase() -> AuthUseCase {
		return NetAuthUseCase(network: networkProvider.makeAuthNetwork())
	}
}
