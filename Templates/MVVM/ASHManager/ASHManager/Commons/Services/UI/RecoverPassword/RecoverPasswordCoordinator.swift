//
//  RecoverPasswordCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class RecoverPasswordCoordinator: BaseCoordinator<Void> {
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		guard let viewModel = viewModel as? RecoverPasswordViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let cancel = viewModel.didCancel
		
		// Did send code
		let didSentCode = viewModel.didSentCode
			.flatMap { [weak self] _ -> Observable<Void> in
				guard let strongSelf = self else { return .empty() }
				return strongSelf.coordinateToResetPassword()
			}
			.subscribe()
		
		// Merge action
		return cancel
			.take(1)
			.do(onNext: { _ in
				didSentCode.dispose()
			})
	}
}

// MARK: - ########################## Final ##########################
extension RecoverPasswordCoordinator: RecoverPasswordCoordinatorProtocol {
}
