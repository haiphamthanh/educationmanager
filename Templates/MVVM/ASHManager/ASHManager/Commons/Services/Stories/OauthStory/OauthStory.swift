//
//  OauthStory.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Swinject
import RxSwift

// MARK: - ########################## STORY ##########################
class OauthStory: BaseCoordinator<Void> {
	// MARK: - ================================= Proxy action =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return driverCoordinator()
	}
}

// MARK: - ########################## Register Story Manager ##########################
private extension OauthStory {
	// Driver
	func driverCoordinator() -> Observable<Void> {
		return authTask()
	}
	
	// Tasks
	func authTask() -> Observable<Void> {
		return bringMeToAuth()
			.do(onNext: { _ in })
	}
}

// MARK: - ########################## PROVIDERS ##########################
// MARK: Manager ------------------
extension OauthStory {
	static func oauthStory(params: Dictionary<String, Any>? = nil) -> OauthStory {
		return OauthStory()
	}
}

// MARK: Sub coordinators ------------------
/**
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension OauthStory {
	static func authCoordinator(params: Dictionary<String, Any>? = nil) -> AuthCoordinator {
		let coordinator = container.sureResolve(AuthCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! AuthCoordinator
	}
	
	// MARK: #################### TERM OF USE #################
	static func termOfUseCoordinator(params: Dictionary<String, Any>? = nil) -> TermOfUseCoordinator {
		let coordinator = container.sureResolve(TermOfUseCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! TermOfUseCoordinator
	}
	
	// MARK: ################# RECOVER PASSWORD #################
	static func recoverPasswordCoordinator(params: Dictionary<String, Any>? = nil) -> RecoverPasswordCoordinator {
		let coordinator = container.sureResolve(RecoverPasswordCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! RecoverPasswordCoordinator
	}
	
	// MARK: ################### RESET PASSWORD #################
	static func resetPasswordCoordinator(params: Dictionary<String, Any>? = nil) -> ResetPasswordCoordinator {
		let coordinator = container.sureResolve(ResetPasswordCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! ResetPasswordCoordinator
	}
}
