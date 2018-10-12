//
//  AppCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/9/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class AppCoordinator: BaseAppCoordinator {
	// MARK: - ================================= Init =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return proxyCoordinator()
	}
}

private extension AppCoordinator {
	// Usage functions
	func proxyCoordinator() -> Observable<Void> {
		let storyCompletion = { [weak self] (_: Void) in
			guard let strongSelf = self else { return }
			strongSelf.proxyCoordinator()
				.subscribe()
				.disposed(by: strongSelf.disposeBag)
		}
		
		// Goto intro for fist time install application
		let isFirstInstall = !UserDefaults.standard.bool(forKey: "INSTALLED_BEFORE")
		if isFirstInstall {
			//			UserDefaults.standard.set(true, forKey: "INSTALLED_BEFORE")
			return coordinateToIntro()
				.do(onNext: storyCompletion)
			
		}
		
		// Goto signin if does not authen before
		let isSigned = UserDefaults.standard.bool(forKey: "LOGGED_IN")
		if isSigned {
			return coordinateToAuth()
				.do(onNext: storyCompletion)
		}
		
		// Goto home if signed
		return coordinateToHome()
			.do(onNext: storyCompletion)
	}
}
