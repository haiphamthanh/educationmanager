//
//  NetworkingInfrastructor.swift
//  ASEducation
//
//  Created by HaiPT15 on 10/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Moya
import Alamofire

class NetworkingInfrastructor<T: TargetType> {
	static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType, T: APIType {
		return { target in
			var endpoint: Endpoint = Endpoint(url: url(target),
											  sampleResponseClosure: { .networkResponse(200, target.sampleData) },
											  method: target.method,
											  task: target.task,
											  httpHeaderFields: nil)
			
			// If we were given an xAccessToken, add it
			if let xAccessToken = xAccessToken {
				endpoint = endpoint.adding(newHTTPHeaderFields: [ConstantOauthKey.accessTokenHeader: xAccessToken])
			}
			
			return endpoint
		}
	}
	
	static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
		return APIKeys.sharedKeys.stubResponses ? .immediate : .never
	}
	
	static var manager: Manager {
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		configuration.timeoutIntervalForRequest = ConstantRequestManager.httpTimeOutSec() // as seconds, you can set your request timeout
		configuration.timeoutIntervalForResource = ConstantRequestManager.maxTimeDownloadFile() // as seconds, you can set your resource timeout
		configuration.requestCachePolicy = .useProtocolCachePolicy
		
		let serverTrustPolicyManager = NewServerTrustPolicyManager()
		
		return Manager (
			configuration: configuration,
			serverTrustPolicyManager: serverTrustPolicyManager
		)
	}
	
	static var plugins: [PluginType] {
		return [
			NetworkLogger(blacklist: { target -> Bool in
				return !(target is PingAPI)
			})
		]
	}
	
	static var authenticatedPlugins: [PluginType] {
		return [
			NetworkLogger(whitelist: { target -> Bool in
				return !(target is PingAPI)
			})
		]
	}
	
	// (Endpoint, NSURLRequest -> Void) -> Void
	static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
		return { (endpoint, closure) in
			do {
				var request = try endpoint.urlRequest()
				request.httpShouldHandleCookies = false
				closure(.success(request))
			} catch let error {
				closure(.failure(MoyaError.underlying(error, nil)))
			}
		}
	}
	
	private class NewServerTrustPolicyManager: ServerTrustPolicyManager {
		override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
			if let serverTrustPolicy = policies[host] {
				return serverTrustPolicy
			}
			return ServerTrustPolicy.performDefaultEvaluation(validateHost: true)
		}
		
		public init() {
			super.init(policies: [Server.shared.root: .disableEvaluation,
								  Server.shared.supportLink: .disableEvaluation])
		}
	}
	
	private class func url(_ route: TargetType) -> String {
		return route.baseURL.appendingPathComponent(route.path).absoluteString
	}
}

// Provide sample data for testing
func stubbedResponse(_ filename: String) -> Data! {
	@objc class TestClass: NSObject { }
	
	let bundle = Bundle(for: TestClass.self)
	let path = bundle.path(forResource: filename, ofType: "json")
	return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
	var URLEscapedString: String {
		return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
	}
}
