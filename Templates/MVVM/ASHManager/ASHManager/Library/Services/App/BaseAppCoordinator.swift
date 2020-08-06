//
//  BaseAppCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/17/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BaseAppCoordinator: BaseCoordinator<Void> {
	// MARK: - ================================= Proxy action =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return proxyCoordinator()
	}
	
	// MARK: - ########################## Customization ##########################
	var isExtentStoryUsing: Bool {
		return false
	}
	
	/// Add more external story tasks
	///
	/// - Returns: external task manager
	func extentsStoryAdapter() -> Observable<Void> {
		fatalError("Implement in subclass")
	}
}

// MARK: - ########################## Final ##########################
extension BaseAppCoordinator: AppCoordinatorProtocol {
}

// MARK: - ########################## Use StoriesManager ##########################
private extension BaseAppCoordinator {
	// Usage functions
	func proxyCoordinator() -> Observable<Void> {
		// Validate before enter to app
		let isValidApp = isValidApplication()
		if !isValidApp {
			return doneStory(params: nil)
		}
		
		return driverCoordinator()
	}
	
	// Driver
	func driverCoordinator() -> Observable<Void> {
		let storyCompletion = { [weak self] (_: Void) in
			guard let strongSelf = self else { return }
			strongSelf.driverCoordinator()
				.subscribe()
				.disposed(by: strongSelf.disposeBag)
		}
		
		// Goto intro for fist time install application
		let isFirstInstall = !UserDefaults.standard.bool(forKey: "INSTALLED_BEFORE")
		if isFirstInstall {
			UserDefaults.standard.set(true, forKey: "INSTALLED_BEFORE")
			return introStoryTask(storyCompletion)
		}
		
		// Goto home if signed
		let isSigned = AppDelegate.shared()
			.globalManager
			.account
			.signInInfo()
			.isSigned
		if isSigned {
			return homeStoryTask(storyCompletion)
		}
		
		// Goto signin if does not authen
		return oauthStoryTask(storyCompletion)
	}
	
	// Stories
	func introStoryTask(_ storyCompletion: @escaping (() -> Void)) -> Observable<Void> {
		return startIntroStory()
			.do(onNext: storyCompletion)
	}
	
	func oauthStoryTask(_ storyCompletion: @escaping (() -> Void)) -> Observable<Void> {
		return startOauthStory()
			.do(onNext: storyCompletion)
	}
	
	func homeStoryTask(_ storyCompletion: @escaping (() -> Void)) -> Observable<Void> {
		return startHomeStory()
			.do(onNext: storyCompletion)
	}
	
	func extentsStoryTask(_ storyCompletion: @escaping (() -> Void)) -> Observable<Void> {
		return extentsStoryAdapter()
			.do(onNext: storyCompletion)
	}
	
	// TODO: Check app for secure
	func isValidApplication() -> Bool {
		return true
	}
}
