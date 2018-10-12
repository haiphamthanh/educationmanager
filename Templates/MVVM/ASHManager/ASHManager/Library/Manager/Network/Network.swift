//
//  NetworkServiceProtocol.swift
//  SwinjectMVVMExample
//
//  Created by Yoichi Tagaya on 8/22/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper
import Moya
import Alamofire
import CocoaLumberjack

private func JSONResponseDataFormatter(_ data: Data) -> Data {
	do {
		let dataAsJSON = try JSONSerialization.jsonObject(with: data)
		let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
		return prettyData
	} catch {
		return data //fallback to original data if it cant be serialized
	}
}

final class Network<T: ImmutableMappable, A: TargetType> {
	private let scheduler: ConcurrentDispatchQueueScheduler
	
	init() {
		self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
	}
	
	func requestRx(api: A) -> Observable<[T]> {
		return requestDataRx(api: api)
			.debug()
			.observeOn(scheduler)
			.map({ json -> [T] in
				return try Mapper<T>().mapArray(JSONObject: json)
			})
	}
	
	func requestBgRx(api: A) -> Observable<[T]> {
		return requestDataOnBgRx(api: api)
			.debug()
			.observeOn(scheduler)
			.map({ json -> [T] in
				return try Mapper<T>().mapArray(JSONObject: json)
			})
	}
	
	func requestRx(api: A) -> Observable<T> {
		return requestDataRx(api: api)
			.debug()
			.observeOn(scheduler)
			.map({ json -> T in
				do {
					let data = try Mapper<T>().map(JSONObject: json)
					return data
				} catch {
					let reponseObject = try Mapper<ResponseObject>().map(JSONObject: json)
					if let error = reponseObject.handleWithStatusCode() {
						throw error
					}
					
					return try Mapper<T>().map(JSONObject: reponseObject.body)
				}
			})
	}
	
	func requestBgRx(api: A) -> Observable<T> {
		return requestDataOnBgRx(api: api)
			.debug()
			.observeOn(scheduler)
			.map({ json -> T in
				do {
					let data = try Mapper<T>().map(JSONObject: json)
					return data
				} catch {
					let reponseObject = try Mapper<ResponseObject>().map(JSONObject: json)
					if let error = reponseObject.handleWithStatusCode() {
						throw error
					}
					
					return try Mapper<T>().map(JSONObject: reponseObject.body)
				}
			})
	}
	
	private func requestDataOnBgRx(api: A) -> Observable<Any> {
		DDLogDebug("make request = \(A.self)")
		return Observable.create({ observer -> Disposable in
			let request = self.provider(A: api).request(api, completion: { result in
				DispatchQueue.main.async {
					GKIndicatorView.shared.hide()
				}
				
				do {
					if let error = result.error {
						if let statusCode = error.response?.statusCode {
							if statusCode == 401 {
								let network = AuthNetwork()
								if let refreshToken = Config.appRefreshToken() {
									print("http://10.88.16.88/api/v1/user/new_token Refreshing \(refreshToken)")
									
									let _ = network.refreshToken(token: refreshToken)
										.subscribe(onNext: { (data) in
											Config.keep(token: data.token, roleId: 1)
											Config.keep(refreshToken: data.refreshToken)
											let target = RetryTarget(target: api, newToken: data.token)
											let network = Network<T, RetryTarget>()
											let data: Observable<Any> = network.requestDataRx(api: target)
											let _ = data.subscribe(onNext: { (value) in
												observer.onNext(value)
												observer.onCompleted()
											}, onError: { (error) in
												observer.onError(error)
											})
										}, onError: { (error) in
											Config.revokeToken()
											print("http://10.88.16.88/api/v1/user/new_token END")
										})
									Config.keep(refreshToken: nil)
									return
								}
							}
						}
						if let responseError = error.toGKError.gkResponseError.first {
							observer.onError(responseError)
							return
						}
						if let networkError = error.toGKError.networkError {
							observer.onError(networkError)
							return
						}
					}
					
					if case let .success(response) = result {
						let value = try self.serialize(reponse: response)
						
						let error = GKError(response: response)
						if let responseError = error.gkResponseError.first {
							observer.onError(responseError)
						} else {
							observer.onNext(value)
							observer.onCompleted()
						}
						return
					}
					
					
				} catch {
					let printableError = error as CustomStringConvertible
					print(printableError.description)
					observer.onError(GKNetworkError(error: error))
				}
			})
			
			return Disposables.create {
				request.cancel()
			}
		})
	}
	
	private func requestDataRx(api: A) -> Observable<Any> {
		DispatchQueue.main.async {
			GKIndicatorView.shared.show()
		}
		
		return requestDataOnBgRx(api: api)
	}
	
	func requestDownloadRx(api: A) -> Observable<URL?> {
		
		DDLogDebug("make request = \(A.self)")
		return Observable.create({ observer -> Disposable in
			let request = self.provider(A: api).request(api, completion: { result in
				if case let .success(response) = result {
					let url = response.response?.url
					observer.onNext(url)
					observer.onCompleted()
					return
				}
				
				if let error = result.error {
					if let responseError = error.toGKError.gkResponseError.first {
						observer.onError(responseError)
						return
					}
					if let networkError = error.toGKError.networkError {
						observer.onError(networkError)
					}
				}
			})
			
			return Disposables.create {
				request.cancel()
			}
		})
	}
	
	private func provider(A: TargetType) -> MoyaProvider<A> {
		let manager = Manager(
			configuration: URLSessionConfiguration.default,
			serverTrustPolicyManager: GKServerTrustPolicyManager()
		)
		let provider = MoyaProvider<A>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
		return provider

	}
	
	func serialize(reponse: Response) throws -> Any {
		let any = try reponse.mapJSON()
		guard let data = any as? Dictionary<String, Any> else {
			guard let array = any as? [Any] else {
				throw MoyaError.jsonMapping(reponse)
			}
			return array
		}
		
		return data
	}
}

class RetryTarget: TargetType {
	var baseURL: URL
	
	var path: String
	
	var method: Moya.Method
	
	var sampleData: Data
	
	var task: Task
	
	var headers: [String : String]?
	
	init(target: TargetType, newToken: String) {
		self.baseURL = target.baseURL
		self.path = target.path
		self.method = target.method
		self.sampleData = target.sampleData
		self.headers = target.headers
		self.task = target.task
		switch target.task {
		case .requestParameters(let parameters, let encoding):
			var param = parameters
			param["token"] = newToken
			self.task = .requestParameters(parameters: param, encoding: encoding)
		default:
			break
		}
	}
}

class GKServerTrustPolicyManager: ServerTrustPolicyManager {
	override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
		if let serverTrustPolicy = policies[host] {
			return serverTrustPolicy
		}
		return ServerTrustPolicy.performDefaultEvaluation(validateHost: true)
	}
	
	public init() {
		super.init(policies: ["10.88.16.88": .disableEvaluation,
							  "genki-alb-dev-71238201.ap-northeast-1.elb.amazonaws.com": .disableEvaluation,
							  "de-genkius.genkimiru.jp": .disableEvaluation])
	}
}
