//
//  RecoverPasswordViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//
import RxSwift

class RecoverPasswordViewModel: ViewModelAdapter {
	private let _cancel = PublishSubject<Void>()
	private let _didSentCode = PublishSubject<Void>()
	
	deinit {
		_cancel.onNext(())
	}
}

// MARK: - ########################## Final ##########################
extension RecoverPasswordViewModel: RecoverPasswordViewModelProtocol {
	// MARK: View - Action
	func sendCode(toEmail: String) {
		sendCode(to: toEmail)
	}
	
	// MARK: - Outputs
	var didCancel: Observable<Void> {
		return _cancel.asObservable()
	}
	
	var didSentCode: Observable<Dictionary<String, Any>?> {
		return _didSentCode
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
			.asObservable()
	}
}

// MARK: - ================================= Private =================================
private extension RecoverPasswordViewModel {
	func sendCode(to email: String) {
		_didSentCode.onNext(())
	}
	
	
//	func sendCode(to email: String) {
//		if let message = Validate.isValidEmail(email: email) {
//			return showOKDialog(message: message)
//		}
//
//		return gkNetworkService
//			.requestResetPasswordCode(by: email)
//			.flatMap(didSentPinCode)
//			.subscribe()
//			.disposed(by: disposeBag)
//	}
	
	func didSentPinCode() -> Observable<Void> {
		return _didSentCode
	}
}
