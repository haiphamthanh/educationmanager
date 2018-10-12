//
//  AccountRegisterCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class AccountRegisterCoordinator: BaseCoordinator<Void> {
}

// MARK: - ########################## Final ##########################
extension AccountRegisterCoordinator: AccountRegisterCoordinatorProtocol {
}

// MARK: - ########################## ViewModelCoordinatorDelegate ##########################
//extension BasicInformationCoordinator: BasicInformationViewModelCoordinatorDelegate {
//	func gotoTermOfUse(params: Dictionary<String, Any>?) -> Observable<Void> {
//		return coordinateToTermOfUse(sender: self, params: params)
//	}
//
//	func didSignUp(params: Dictionary<String, Any>?) -> Observable<Void> {
//		return coordinateToHome(sender: self, params: params)
//	}
//}
