//
//  UserInfoCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class UserInfoCoordinator: HomeBaseCoordinator {
	override var sideMenuType: SideMenuType {
		return .userInfo
	}
	
	override func doActionCustomize(viewModel: BaseViewModelProtocol?) -> Observable<SideMenuType> {
		guard let viewModel = viewModel as? UserInfoViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let done = viewModel.didDone
		
		// Merge action
		return done.map({ .userInfo })
	}
}

// MARK: - ########################## Final ##########################
extension UserInfoCoordinator: UserInfoCoordinatorProtocol {
}
