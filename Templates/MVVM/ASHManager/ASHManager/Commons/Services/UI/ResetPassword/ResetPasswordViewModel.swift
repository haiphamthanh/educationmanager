//
//  ResetPasswordViewModel.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/5/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ResetPasswordViewModel: ViewModelAdapter {
	// MARK: - ================================= Properties =================================
	// Data from view to viewmodel
	private var _pinCode = BehaviorSubject<String>(value: "")
	private var _newPassword = BehaviorSubject<String>(value: "")
	private var _confirmPassword = BehaviorSubject<String>(value: "")
	
	private let _cancel = PublishSubject<Void>()
	private let _didResetPassword = PublishSubject<Void>()
	
	// Data private
	private var pPinCode: String?
	private var pNewPassword: String?
	private var pConfirmPassword: String?
	
	private var errorMessage: String?
	private var canResetPassword: Bool {
		return errorMessage == nil
	}
	
	override func initialize(params: Dictionary<String, Any>?) {
		super.initialize(params: params)
		
//		setupValidation()
	}
	
	deinit {
		_cancel.onNext(())
	}
}

// MARK: - ########################## Final ##########################
extension ResetPasswordViewModel: ResetPasswordViewModelProtocol {
	// Data from view to viewmodel
	var pinCode: BehaviorSubject<String> {
		return _pinCode
	}
	
	var newPassword: BehaviorSubject<String> {
		return _newPassword
	}
	
	var confirmPassword: BehaviorSubject<String> {
		return _confirmPassword
	}
	
	// MARK: View - Action
	func resetPassword() {
		_didResetPassword.onNext(())
	}
	
	// MARK: - Outputs
	var didCancel: Observable<Void> {
		return _cancel.asObserver()
	}
	
	var didResetPassword: Observable<Dictionary<String, Any>?> {
		return _didResetPassword
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
			.asObservable()
	}
}

// MARK: - ================================= Private =================================
private extension ResetPasswordViewModel {
	func setupValidation() {
		let isValidResetPassword = Observable.combineLatest(pinCode, newPassword, confirmPassword) { [weak self] (pc, npw, cpw) in
			if let message = Validate.isValidAuthInputLength(inputString: pc) {
				self?.errorMessage = message
			} else if let message = Validate.isValidAuthInputLength(inputString: npw) {
				self?.errorMessage = message
			} else if let message = Validate.isValidAuthInputLength(inputString: cpw) {
				self?.errorMessage = message
			} else if let message = Validate.isValidAuthInput(newPassword: npw, confirmPassword: cpw) {
				self?.errorMessage = message
			} else {
				self?.pPinCode = pc
				self?.pNewPassword = npw
				self?.pConfirmPassword = cpw
			}
		}
		
		isValidResetPassword
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	func resetPasswordCompleted() -> Observable<Void> {
		return _didResetPassword
	}
	
//	func resetPassword() {
//		if !canResetPassword {
//			return showOKDialog(message: LocalizedString.localizedString(input: "Input_Error_Title"))
//		}
//		
//		let success = strongify(self, closure: { (instance, _: Void) in
//			instance.showToast(message: LocalizedString.localizedString(input: "Reset_Password_Success_Message"))
//		})
//		
//		let error = { [unowned self] (error: Error) in
//			self.showOKDialog(message: LocalizedString.localizedString(input: "Reset_Password_Fail_Message"))
//		}
//		
//		gkNetworkService
//			.resetPassword(from: pPinCode!, newPassword: pNewPassword!)
//			.flatMap(didResetPassword)
//			.observeOn(MainScheduler.instance)
//			.subscribe(onNext: success, onError: error)
//			.disposed(by: disposeBag)
//	}
//	
}
