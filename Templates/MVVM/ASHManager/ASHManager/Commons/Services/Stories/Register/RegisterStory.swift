//
//  RegisterStory.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Swinject
import RxSwift

// MARK: - ########################## STORY ##########################
class RegisterStory: BaseCoordinator<Void> {
	// MARK: - ================================= Proxy action =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return driverCoordinator()
	}
}

// MARK: - ########################## Register Story Manager ##########################
private extension RegisterStory {
	// Driver
	func driverCoordinator() -> Observable<Void> {
		return registrationTask()
	}
	
	// Tasks
	func registrationTask() -> Observable<Void> {
		return bringMeToToRegister()
			.do(onNext: { _ in })
	}
}

// MARK: - ########################## PROVIDERS ##########################
// MARK: Manager ------------------
extension RegisterStory {
	static func registerStory(params: Dictionary<String, Any>? = nil) -> RegisterStory {
		return RegisterStory()
	}
}

// MARK: Sub coordinators ------------------
/**
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension RegisterStory {
	static func registrationCoordinator(params: Dictionary<String, Any>? = nil) -> RegisterCoordinator {
		let coordinator = container.sureResolve(RegisterCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! RegisterCoordinator
	}
	
	static func userInfoRegistrationCoordinator(params: Dictionary<String, Any>? = nil) -> AccountRegisterCoordinator {
		let coordinator = container.sureResolve(AccountRegisterCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! AccountRegisterCoordinator
	}
}
