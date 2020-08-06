//
//  LoadingManager.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/24/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol LoadingManagerProtocol {
	func startInternetTracking()
	func waitForRequest()
	func endRequest()
}

class LoadingManager {
	// MARK: - ================================= Properties =================================
	static let shared = LoadingManager()
	
	private let disposeBag = DisposeBag()
	private var type = LoadingType.network
	private lazy var loadingVC = LoadingViewController()
	
	// TODO: Move to network manager later
	private let syncInterval: TimeInterval = 2
	private lazy var pingNetwork = PingNetwork()
	
	// private init as singleton pattern
	private init() {
	}
}

extension LoadingManager: LoadingManagerProtocol {
}

// MARK: Check for internet =================================
extension LoadingManager {
	func startInternetTracking() {
		let letOnline = Observable<Int>
			.interval(syncInterval, scheduler: MainScheduler.instance)
			.flatMap { [weak self] _ in
				return self?.ping() ?? .empty()
			}
			.retry() // Retry because ping may fail when disconnected and error.
			.startWith(true)
		
		let internetChecking = strongify(self, closure: { (instance, isConnected: Bool) in
			instance.dissmissLoadingView()
			
			if !isConnected {
				return instance.showLoadingView(type: .network)
			}
			
			return instance.dissmissLoadingView()
		})
		
		[connectedToInternetOrStubbing(), letOnline]
			.combineLatestAnd()
			.subscribe(onNext: internetChecking)
			.disposed(by: disposeBag)
	}
}

// MARK: Data waiting =================================
extension LoadingManager {
	func waitForRequest() {
		return showLoadingView(type: .normal)
	}
	
	func endRequest() {
		return dissmissLoadingView()
	}
}

// MARK: - ================================= usage function list =================================
private extension LoadingManager {
	func showLoadingView(type: LoadingType) {
		guard let root = UIApplication.topViewController() else {
			return
		}
		
		loadingVC.change(type: type)
		root.present(loadingVC, animated: true, completion: nil)
		root.dismiss(animated: true, completion: nil)
	}
	
	func dissmissLoadingView() {
		guard let root = UIApplication.topViewController() else {
			return
		}
		
		return root.dismiss(animated: true, completion: nil)
	}
	
	func ping() -> Observable<Bool> {
		let input: Void = InNWPing()
		let out = pingNetwork.ping(input: input)
		
		let _ = out.requestId
		let result = out.result
		
		return result
	}
}
