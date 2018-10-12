//
//  AdapterCoordinator+Extension.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/14/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import SwiftyUserDefaults

/**
Provide authentication coordinator

- parameter sender: target handle action Coordinator Delegate
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension BaseCoordinator {
	
	// MARK: - -------------------------------------------- Intro --------------------------------------------
	func coordinateToIntro(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.introCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	// MARK: - -------------------------------------------- Register --------------------------------------------
	func coordinateToRegister(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.userInfoRegistrationCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	func coordinateToBasicInfoRegister(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.registrationCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	// MARK: - -------------------------------------------- Auth --------------------------------------------
	func coordinateToAuth(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.authCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	//MARK: #################### TERM_OF_USE ####################
	func coordinateToTermOfUse(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.termOfUseCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	//MARK: #################### RECOVER_PASSWORD ####################
	func coordinateToForgotPassword(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.recoverPasswordCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	//MARK: #################### RESET_PASSWORD ####################
	func coordinateToResetPassword(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.resetPasswordCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	// MARK: - -------------------------------------------- Home --------------------------------------------
	func coordinateToHome(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = CoordinatorManager.homeCoordinator(params: params)
		return coordinate(to: coordinator)
	}
}
