//
//  NetDeviceUseCase.swift
//  ASHManager
//
//  Created by KhoaLA on 4/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

final class NetDeviceUseCase: DeviceUseCase {
	private let network: DeviceNetwork
	
	init(network: DeviceNetwork) {
		self.network = network
	}
	
	func gobeProfile(userName: String, password: String) -> Observable<UserData> {
		return network.fetchUserGobeData(userName: userName, password: password)
	}
	
	func fitbitProfile(from code: String) -> Observable<UserData> {
		return network.fetchUserFitbitData(from: code)
	}
}
