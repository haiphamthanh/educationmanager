//
//  HomeStory.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Swinject
import RxSwift

// MARK: - ########################## STORY ##########################
class HomeStory: BaseCoordinator<Void> {
	// MARK: - ================================= Proxy action =================================
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		return driverCoordinator()
	}
}

// MARK: - ########################## Register Story Manager ##########################
private extension HomeStory {
	// Driver
	func driverCoordinator() -> Observable<Void> {
		return driverCoordinator(to: .home)
	}
	
	// Tasks
	func driverCoordinator(to index: SideMenuType) -> Observable<Void> {
		// Driver data - Update stack views to only current view
		switch index {
		case .home:
			return homeTask().debug()
				.flatMap(driverCoordinator)
		case .userInfo:
			return userInfoTask().debug()
				.flatMap(driverCoordinator)
		}
	}
	
	func homeTask() -> Observable<SideMenuType> {
		return bringMeToHome()
			.do(onNext: { _ in })
	}
	
	func userInfoTask() -> Observable<SideMenuType> {
		return bringMeToUserInfo()
			.do(onNext: { _ in })
	}
}

// MARK: - ########################## PROVIDERS ##########################
// MARK: Manager ------------------
extension HomeStory {
	static func homeStory(params: Dictionary<String, Any>? = nil) -> HomeStory {
		return HomeStory()
	}
}

// MARK: Sub coordinators ------------------
/**
- parameter params: INPUT for push view controller, manage by NavigationParameters
*/
extension HomeStory {
	static func homeCoordinator(params: Dictionary<String, Any>? = nil) -> HomeCoordinator {
		let coordinator = container.sureResolve(HomeCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! HomeCoordinator
	}
	
	static func userInfoCoordinator(params: Dictionary<String, Any>? = nil) -> UserInfoCoordinator {
		let coordinator = container.sureResolve(UserInfoCoordinatorProtocol.self)
		coordinator.push(params: params)
		return coordinator as! UserInfoCoordinator
	}
}
