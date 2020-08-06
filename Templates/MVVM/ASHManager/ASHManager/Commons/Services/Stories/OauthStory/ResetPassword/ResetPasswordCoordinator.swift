//
//  ResetPasswordCoordinator.swift
//  ASHManager
//
//  Created by HieuFPT on 1/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ResetPasswordCoordinator: BaseCoordinator<Void> {
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		guard let viewModel = viewModel as? ResetPasswordViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let done = viewModel.didDone
		
		// Did send code
		let didResetPassword = viewModel.didResetPassword
			.flatMap(doneStory)
		
		// Merge action
		return Observable.merge(done, didResetPassword)
			.take(1)
			.do(onNext:{ })
	}
}

// MARK: - ########################## Final ##########################
extension ResetPasswordCoordinator: ResetPasswordCoordinatorProtocol {
}
