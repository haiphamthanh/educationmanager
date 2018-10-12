//
//  NetworkProvider.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Moya

final class NetworkProvider {
	func makeAuthNetwork() -> AuthNetwork {
		return AuthNetwork.init()
	}
	
	func makeUserNetwork() -> UserNetwork {
		return UserNetwork.init()
	}
	
	public func makeDeviceNetwork() -> DeviceNetwork {
		return DeviceNetwork.init()
	}
}
