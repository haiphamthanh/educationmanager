//
//  Functionals.swift
//  ASEducation
//
//  Created by 7i3u7u on 10/26/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Moya
import RxSwift
import Reachability

// MARK: - Networking =================================
private let reachabilityManager = ReachabilityManager()
private class ReachabilityManager {
	private let reachability: Reachability
	
	let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
	var reach: Observable<Bool> {
		return _reach.asObservable()
	}
	
	init?() {
		guard let r = Reachability() else {
			return nil
		}
		self.reachability = r
		
		do {
			try self.reachability.startNotifier()
		} catch {
			return nil
		}
		
		self._reach.onNext(self.reachability.connection != .none)
		
		self.reachability.whenReachable = { _ in
			DispatchQueue.main.async { self._reach.onNext(true) }
		}
		
		self.reachability.whenUnreachable = { _ in
			DispatchQueue.main.async { self._reach.onNext(false) }
		}
	}
	
	deinit {
		reachability.stopNotifier()
	}
}

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternetOrStubbing() -> Observable<Bool> {
	let stubbing = Observable.just(APIKeys.sharedKeys.stubResponses)
	
	guard let online = reachabilityManager?.reach else {
		return stubbing
	}
	
	return [online, stubbing].combineLatestOr()
}

// MARK: - Enviroment =================================
func environmentDetected() -> AppEnviroment {
	var environment: AppEnviroment = .staging
	#if DEBUG || targetEnvironment(simulator)
		environment = .development
	#elseif PRODCUTION
		environment = .production
	#endif
	
	return environment
}

// MARK: - Logger =================================
func logPath() -> URL {
	let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
	return docs.appendingPathComponent("logger.txt")
}

let logger = Logger(destination: logPath())

func bindingErrorToInterface(_ error: Swift.Error) {
	let error = "Binding error to UI: \(error)"
	#if DEBUG
		fatalError(error)
	#else
		print(error)
	#endif
}

// MARK: - Response =================================
func responseIsOK(_ response: Response) -> Bool {
	return response.statusCode == 200
}

struct MapFromNever: Error {}
extension ObservableType where E == Never {
	func map<T>(to: T.Type) -> Observable<T> {
		return self.flatMap { _ in
			return Observable<T>.error(MapFromNever())
		}
	}
}
