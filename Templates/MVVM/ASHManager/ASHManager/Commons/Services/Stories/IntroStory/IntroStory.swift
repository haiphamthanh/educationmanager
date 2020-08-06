//
//  IntroStory.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Swinject
import RxSwift

// MARK: - ########################## STORY ##########################
class IntroStory: BaseCoordinator<Void> {
	// MARK: - ================================= Proxy action =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return driverCoordinator()
	}
}

// MARK: - ########################## Intro Story Manager ##########################
private extension IntroStory {
	// Driver
	func driverCoordinator() -> Observable<Void> {
		return introductionTask()
	}
	
	// Tasks
	func introductionTask() -> Observable<Void> {
		return bringMeToIntro()
			.do(onNext: { _ in })
	}
}

// MARK: - ########################## PROVIDERS ##########################
// MARK: Manager ------------------
extension IntroStory {
	static func introStory(params: Dictionary<String, Any>? = nil) -> IntroStory {
		return IntroStory()
	}
}

// MARK: Sub coordinators ------------------
/**
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension IntroStory {
	static func introCoordinator(params: Dictionary<String, Any>? = nil) -> IntroCoordinator {
		let coordinator = container.sureResolve(IntroCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! IntroCoordinator
	}
}
