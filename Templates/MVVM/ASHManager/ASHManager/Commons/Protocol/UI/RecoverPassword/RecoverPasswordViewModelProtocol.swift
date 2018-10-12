//
//  RecoverPasswordViewModelProtocol.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol RecoverPasswordViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: - Inputs
	// MARK: View - Action
	func sendCode(toEmail: String)
	
	// MARK: - Outputs
	var didCancel: Observable<Void> { get }
	var didSentCode: Observable<Dictionary<String, Any>?> { get }
}
