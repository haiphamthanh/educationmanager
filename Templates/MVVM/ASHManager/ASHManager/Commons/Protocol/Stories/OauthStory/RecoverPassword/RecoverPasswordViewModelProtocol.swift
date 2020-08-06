//
//  RecoverPasswordViewModelProtocol.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol RecoverPasswordViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	func sendCode(toEmail: String)
	
	// MARK: Coordinator - Outputs
	var didSentCode: Observable<Dictionary<String, Any>?> { get }
}
