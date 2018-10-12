//
//  IntroCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class IntroCoordinator: BaseCoordinator<Void> {
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		guard let viewModel = viewModel as? IntroViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let done = viewModel.didDone
		
		// Login
		let login = viewModel.willSignIn
			.flatMap { [weak self] _ -> Observable<Void> in
				guard let strongSelf = self else { return .empty() }
				return strongSelf.coordinateToAuth()
			}
			.subscribe()
		
		// Register
		let register = viewModel.willSignUp
			.flatMap { [weak self] _ -> Observable<Void> in
				guard let strongSelf = self else { return .empty() }
				return strongSelf.coordinateToRegister()
			}
			.subscribe()
		
		// Merge action
		return done
			.take(1)
			.do(onNext: { _ in
				DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
					login.dispose()
					register.dispose()
				}
			})
	}
}

// MARK: - ########################## Final ##########################
extension IntroCoordinator: IntroCoordinatorProtocol {
}
