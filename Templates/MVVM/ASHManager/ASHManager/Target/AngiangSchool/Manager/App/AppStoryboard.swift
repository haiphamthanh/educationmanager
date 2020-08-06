//
//  AppStoryboard.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

extension UIViewController {
	static func newInstance() -> Self {
		let name = AppStoryboard.storyboardName(vc: self)
		return instantiateFromStoryboard(name: name)
	}
}

enum AppStoryboard: String {
	case Intro = "Intro"
	case Register = "Register"
	case Auth = "Auth"
	case TermOfUse = "TermOfUse"
	case RecoverPassword = "RecoverPassword"
	case ResetPassword = "ResetPassword"
	case Home = "Home"
	case UserInfo = "UserInfo"
	
	case Menu = "Menu"
	case Present = "Present"
	
	static func storyboardName(vc: UIViewController.Type) -> String {
		func storyboard() -> AppStoryboard {
			let vcName = String(describing: vc)
			
			if intros().contains(where: { vcName == String(describing: $0) }) {
				return Intro
			}
			
			if registers().contains(where: { vcName == String(describing: $0) }) {
				return Register
			}
			
			if auths().contains(where: { vcName == String(describing: $0) }) {
				return Auth
			}
			
			if homes().contains(where: { vcName == String(describing: $0) }) {
				return Home
			}
			
			if presents().contains(where: { vcName == String(describing: $0) }) {
				return Present
			}
			
			if menus().contains(where: { vcName == String(describing: $0) }) {
				return Menu
			}
			
			if userInfo().contains(where: { vcName == String(describing: $0) }) {
				return UserInfo
			}
			
			fatalError("Cant find view controller defination")
		}
		
		return storyboard().rawValue
	}
	
	// INTRO
	static func intros() -> [AnyClass] {
		return [IntroViewController.self]
	}
	
	// REGISTER
	static func registers() -> [AnyClass] {
		return [AccountRegisterViewController.self,
				
				BasicInforGenderVC.self,
				BasicInforBirthdayVC.self,
				BasicInforProfileVC.self,
				BasicInforAvatarVC.self,
				
				BasicInforNickNameVC.self,
				BasicInforWeightVC.self,
				BasicInforHeightVC.self,
				BasicInforBloodVC.self,
				BasicInforFinishVC.self]
	}
	
	// AUTH
	static func auths() -> [AnyClass] {
		return [ResetPasswordViewController.self,
				RecoverPasswordViewController.self,
				TermOfUseViewController.self,
				AuthViewController.self,
				ASEAuthViewController.self]
	}
	
	// HOME
	static func homes() -> [AnyClass] {
		return [HomeViewController.self,
				ASEHomeViewController.self,
				HomeMainViewController.self,
				HomeNewsViewController.self,
				HomeVideoViewController.self]
	}
	
	// PRESENT
	static func presents() -> [AnyClass] {
		return [PresentViewController.self]
	}
	
	// MENU
	static func menus() -> [AnyClass] {
		return [MenuViewController.self]
	}
	
	// USER_PROFILE
	static func userInfo() -> [AnyClass] {
		return [UserInfoViewController.self,
				ASEUserInfoViewController.self]
	}
}
