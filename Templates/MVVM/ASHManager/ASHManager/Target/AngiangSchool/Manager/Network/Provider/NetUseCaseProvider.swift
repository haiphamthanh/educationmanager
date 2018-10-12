//
//  NetUseCaseProvider.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Moya
import RxSwift

final class NetUseCaseProvider: UseCaseProviderProtocol {
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
	
	func makeDeviceUseCase() -> DeviceUseCase {
		return NetDeviceUseCase(network: networkProvider.makeDeviceNetwork())
	}
}

struct MapFromNever: Error {}
extension ObservableType where E == Never {
	func map<T>(to: T.Type) -> Observable<T> {
		return self.flatMap { _ in
			return Observable<T>.error(MapFromNever())
		}
	}
}
