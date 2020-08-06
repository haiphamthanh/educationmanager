//
//  AuthCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class AuthCoordinator: BaseCoordinator<Void> {
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		guard let viewModel = viewModel as? AuthViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let done = viewModel.didDone
		
		// Did signed in
		let login = viewModel.didSignedIn
			.flatMap(doneStory)
			.subscribe()
		
		// Signup new
		//		let signUpNew = viewModel.signUpNew
		//			.flatMap(coordinateToRegister)
		//			.subscribe()
		
		// Did forgot account
		let forgotPassword = viewModel.didForgotPassword
			.flatMap(bringMeToForgotPassword)
			.subscribe()
		
		// Read term of use
		let readTermOfUse = viewModel.wannaReadTermOfUse
			.flatMap(bringMeToTermOfUse)
			.subscribe()
		
		// Merge action
		return done
			.take(1)
			.do(onNext: { _ in
				login.dispose()
				//				signUpNew.dispose()
				forgotPassword.dispose()
				readTermOfUse.dispose()
			})
	}
}

// MARK: - ########################## Final ##########################
extension AuthCoordinator: AuthCoordinatorProtocol {
}
