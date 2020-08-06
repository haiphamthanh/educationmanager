//
//  BaseCoordinator+Moving.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

/**
Move to any story
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension BaseCoordinator {
	// Introduction
	func startIntroStory(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = IntroStory.introStory()
		return coordinate(to: coordinator)
	}
	
	// MARK: Register
	func startRegisterStory(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = RegisterStory.registerStory()
		return coordinate(to: coordinator)
	}
	
	// MARK: Auth
	func startOauthStory(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = OauthStory.oauthStory()
		return coordinate(to: coordinator)
	}
	
	// MARK: Home
	func startHomeStory(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = HomeStory.homeStory()
		return coordinate(to: coordinator)
	}
}

/**
Move to any screen in stories
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
// MARK: Introduction ------------------
extension BaseCoordinator {
	func bringMeToIntro(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = IntroStory.introCoordinator(params: params)
		return coordinate(to: coordinator)
	}
}

// MARK: Register ------------------
extension BaseCoordinator {
	//MARK: #################### REGISTER ####################
	func bringMeToToRegister(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = RegisterStory.userInfoRegistrationCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	//MARK: #################### USER_INFO ####################
	func bringMeToBasicInfoRegister(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = RegisterStory.registrationCoordinator(params: params)
		return coordinate(to: coordinator)
	}
}

// MARK: Authentication ------------------
extension BaseCoordinator {
	//MARK: #################### AUTHENTICATION ####################
	func bringMeToAuth(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = OauthStory.authCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	//MARK: #################### TERM_OF_USE ####################
	func bringMeToTermOfUse(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = OauthStory.termOfUseCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	//MARK: #################### RECOVER_PASSWORD ####################
	func bringMeToForgotPassword(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = OauthStory.recoverPasswordCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	//MARK: #################### RESET_PASSWORD ####################
	func bringMeToResetPassword(params: Dictionary<String, Any>? = nil) -> Observable<Void> {
		let coordinator = OauthStory.resetPasswordCoordinator(params: params)
		return coordinate(to: coordinator)
	}
}

// MARK: Home ------------------
extension BaseCoordinator {
	func bringMeToHome(params: Dictionary<String, Any>? = nil) -> Observable<SideMenuType> {
		let coordinator = HomeStory.homeCoordinator(params: params)
		return coordinate(to: coordinator)
	}
	
	func bringMeToUserInfo(params: Dictionary<String, Any>? = nil) -> Observable<SideMenuType> {
		let coordinator = HomeStory.userInfoCoordinator(params: params)
		return coordinate(to: coordinator)
	}
}
