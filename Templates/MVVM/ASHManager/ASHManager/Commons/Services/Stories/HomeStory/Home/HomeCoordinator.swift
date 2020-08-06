//
//  HomeCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class HomeCoordinator: HomeBaseCoordinator {
	override var sideMenuType: SideMenuType {
		return .home
	}
	
	override func doActionCustomize(viewModel: BaseViewModelProtocol?) -> Observable<SideMenuType> {
		guard let viewModel = viewModel as? HomeViewModelProtocol else {
			return Observable.never()
		}

		// Done
		let done = viewModel.didDone

		// Merge action
		return done.map({ .home })
	}
}

// MARK: - ########################## Final ##########################
extension HomeCoordinator: HomeCoordinatorProtocol {
}
