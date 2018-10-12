//
//  UseCaseProviderProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

/**
Provide usecase to call api
*/
protocol UseCaseProviderProtocol {
	func makeUserUseCase() -> UserUseCase
	func makeAuthUseCase() -> AuthUseCase
	func makeDeviceUseCase() -> DeviceUseCase
}
