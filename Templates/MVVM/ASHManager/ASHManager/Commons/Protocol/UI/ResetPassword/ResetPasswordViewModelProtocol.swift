//
//  ResetPasswordViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol ResetPasswordViewModelProtocol: ViewModelAdapterProtocol {
	// Data from view to viewmodel
	var pinCode: BehaviorSubject<String> { get }
	var newPassword: BehaviorSubject<String> { get }
	var confirmPassword: BehaviorSubject<String> { get }
	
	// MARK: View - Action
	func resetPassword()
	
	// MARK: - Outputs
	var didCancel: Observable<Void> { get }
	var didResetPassword: Observable<Dictionary<String, Any>?> { get }
}
