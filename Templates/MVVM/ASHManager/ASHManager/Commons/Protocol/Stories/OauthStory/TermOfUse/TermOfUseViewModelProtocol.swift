//
//  TermOfUseViewModelDelegate.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

enum TermOfUseViewType: Int {
	case termOfUse = 0
	case policy
}

struct TermOfUseViewData {
	let viewType: TermOfUseViewType
	let content: String
}

protocol TermOfUseViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var agreeTermOfUse: AnyObserver<Void> { get }
	func select(view: TermOfUseViewType)
	
	// MARK: Coordinator - Outputs
	var understand: Observable<Dictionary<String, Any>?> { get }
}
