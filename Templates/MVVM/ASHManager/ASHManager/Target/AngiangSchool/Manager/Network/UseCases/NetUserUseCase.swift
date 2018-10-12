//
//  NetUserUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import CoreLocation

final class NetUserUseCase: UserUseCase {
	private let network: UserNetwork
	
	init(network: UserNetwork) {
		self.network = network
	}
	
	func register(user: UserData) -> Observable<AuthData> {
		return network.register(user: user)
	}
	
	func userDetail() -> Observable<UserData> {
		return network.detailUser()
	}
	
	func update(user: UserData) -> Observable<Void> {
		return network.updateUser(user: user)
	}
	
	func change(password: String, of userName: String) -> Observable<Void> {
		return network.change(password: password, of: userName)
	}
}
