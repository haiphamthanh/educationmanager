//
//  NetworkingConstructor.swift
//  SwinjectMVVMExample
//
//  Created by Yoichi Tagaya on 8/22/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper
import Moya

enum NetworkingQueue {
	case concurrent
	case serial
}

// MARK: - ================================= Usage network constructor =================================
class NetworkingConstructor<T, O> where T: TargetType, T: APIType, O: ImmutableMappable {
	fileprivate let subscribeScheduler: SchedulerType
	fileprivate let responseScheduler: SchedulerType
	fileprivate let provider: OnlineProvider<T>
	fileprivate let id: Int
	
	init(id: Int, provider: OnlineProvider<T>, queue: NetworkingQueue = .concurrent) {
		self.id = id
		self.provider = provider
		self.responseScheduler = MainScheduler.instance
		
		switch queue {
		case .concurrent:
			self.subscribeScheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: .background,
																						relativePriority: 1))
		case .serial:
			self.subscribeScheduler = SerialDispatchQueueScheduler(qos: .default)
		}
	}
	
	// Use this to call for get response object
	func request(_ api: T) -> Observable<O> {
		let result = proxy(api)
		return result
			.mapJSON()
			.mapTo(object: O.self)
	}
	
	// Use this to call for get list response object
	func request(_ api: T) -> Observable<[O]> {
		let result = proxy(api)
		return result
			.mapJSON()
			.mapTo(arrayOf: O.self)
	}
	
	// Use this to check api
	func request(_ api: T) -> Observable<Bool> {
		let result = startRequest(api)
		return result
			.map(responseIsOK)
	}
}

private extension NetworkingConstructor {
	func startRequest(_ api: T) -> Observable<Moya.Response> {
		let result = proxy(api)
		return result
			.observeOn(responseScheduler)
			.filterSuccessfulStatusCodes()
			.subscribeOn(subscribeScheduler)
			.debug()
			.logError()
	}
	/// Request to fetch a given target. Ensures that valid XAcess tokens exist before making request
	func proxy(_ api: T) -> Observable<Moya.Response> {
		if !api.addXAccess {
			return provider.request(api)
		}
		
		let actualRequest = provider.request(api)
		return XAppTokenRequest()
			.flatMap { _ in actualRequest }
	}
	
	/// Request to fetch and store new XApp token if the current token is missing or expired.
	func XAppTokenRequest() -> Observable<String> {
		var accessToken = XAccessToken()
		
		// If we have a valid token, return it and forgo a request for a fresh one.
		if let token = accessToken.token, accessToken.isValid {
			return Observable.just(token)
		}
		
		let authNetwork = AuthNetwork()
		
		let input = InNWRefreshNewToken(accessToken.refreshToken!)
		let out = authNetwork.refreshNewToken(input: input)
		
		let _ = out.requestId
		let newTokenRequest = out.result
		
		return newTokenRequest
	}
}
