//
//  CoordinatorManager.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/24/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

class CoordinatorManager {
	private static var container: Container {
		return AppDelegate.shared().container
	}
	
	// MARK: - --------------------------------------- Application ---------------------------------------
	static func appCoordinator() -> AppCoordinator {
		let coordinator = container.sureResolve(AppCoordinatorProtocol.self)
		return coordinator as! AppCoordinator
	}
	
	// MARK: - --------------------------------------- Introduction ---------------------------------------
	static func introCoordinator(params: Dictionary<String, Any>? = nil) -> IntroCoordinator {
		let coordinator = container.sureResolve(IntroCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! IntroCoordinator
	}
	
	// MARK: - --------------------------------------- Registration ---------------------------------------
	// MARK: #################### Registration #################
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
	
	// MARK: - --------------------------------------- Authentication ---------------------------------------
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
	
	// MARK: - ------------------------------------------ Home ---------------------------------------
	static func homeCoordinator(params: Dictionary<String, Any>? = nil) -> HomeCoordinator {
		let coordinator = container.sureResolve(HomeCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! HomeCoordinator
	}
}
