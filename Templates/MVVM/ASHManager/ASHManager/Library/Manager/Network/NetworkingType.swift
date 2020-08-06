//
//  NetworkingType.swift
//  ASEducation
//
//  Created by HaiPT15 on 10/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Moya
import RxSwift
import ObjectMapper

protocol NetworkingType {
	associatedtype T: TargetType, APIType
	associatedtype O: ImmutableMappable
	var provider: OnlineProvider<T> { get }
}

// MARK: ================================= request =================================
//// "Public" interfaces
extension NetworkingType {
	// Use this to call for get single response object
	func request(id: Int, _ api: T) -> Observable<O> {
		return constructor(id: id).request(api)
	}
	
	// Use this to call for get list response object
	func request(id: Int, _ api: T) -> Observable<[O]> {
		return constructor(id: id).request(api)
	}
	
	// Use for api cheking
	func request(_ api: T) -> Observable<Bool> {
		return constructor(id: 0).request(api)
	}
	
	private func constructor(id: Int) -> NetworkingConstructor<T, O> {
		return NetworkingConstructor<T, O>.init(id: id, provider: provider)
	}
}

// MARK: ================================= Provider constructor =================================
class OnlineProvider<Target>: MoyaProvider<Target> where Target: TargetType, Target: APIType {
	fileprivate let online: Observable<Bool>
	fileprivate let provider: MoyaProvider<Target>
	
	init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
		 requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
		 stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
		 manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
		 plugins: [PluginType] = [],
		 trackInflights: Bool = false,
		 online: Observable<Bool> = connectedToInternetOrStubbing()) {
		
		self.online = online
		self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
	}
	
	func request(_ token: Target) -> Observable<Moya.Response> {
		let actualRequest = provider.rx.request(token)
		return online
			.ignore(value: false)	// Wait until we're online
			.take(1)				// Take 1 to make sure we only invoke the API once.
			.flatMap { _ in 		// Turn the online state into a network request
				return actualRequest
		}
		
	}
	
	func requestWithProgress(_ token: Target) -> Observable<Moya.ProgressResponse> {
		let actualRequest = provider.rx.requestWithProgress(token)
		return online
			.ignore(value: false)	// Wait until we're online
			.take(1)				// Take 1 to make sure we only invoke the API once.
			.flatMap { _ in 		// Turn the online state into a network request
				return actualRequest
		}
		
	}
}

// MARK: - ================================= Network constructors =================================
final class Networking<T, O>: NetworkingType where T: TargetType, T: APIType, O: ImmutableMappable {
	let provider: OnlineProvider<T>
	init(_ xAccessToken: String? = nil) {
		if environmentDetected() == .development {
			self.provider = newStubProvider()
		} else {
			self.provider = newProvider(NetworkingInfrastructor<T>.authenticatedPlugins,
										xAccessToken: xAccessToken)
		}
	}
}

// MARK: ================================= Provider defincation utils =================================
func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: TargetType, T: APIType {
	return OnlineProvider(endpointClosure: NetworkingInfrastructor<T>.endpointsClosure(xAccessToken),
						  requestClosure: NetworkingInfrastructor<T>.endpointResolver(),
						  stubClosure: NetworkingInfrastructor<T>.APIKeysBasedStubBehaviour,
						  plugins: plugins)
}

func newStubProvider<T>() -> OnlineProvider<T> where T: TargetType, T: APIType {
	return OnlineProvider(endpointClosure: NetworkingInfrastructor<T>.endpointsClosure(),
						  requestClosure: NetworkingInfrastructor<T>.endpointResolver(),
						  stubClosure: MoyaProvider.immediatelyStub,
						  online: .just(true))
}
