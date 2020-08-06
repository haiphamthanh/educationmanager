//
//  ResetPasswordViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol ResetPasswordViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var pinCode: BehaviorSubject<String> { get }
	var newPassword: BehaviorSubject<String> { get }
	var confirmPassword: BehaviorSubject<String> { get }
	func resetPassword()
	
	// MARK: Coordinator - Outputs
	var didResetPassword: Observable<Dictionary<String, Any>?> { get }
}
