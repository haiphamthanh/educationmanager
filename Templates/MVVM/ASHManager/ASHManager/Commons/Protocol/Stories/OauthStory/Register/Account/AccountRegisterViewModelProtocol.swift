//
//  AccountRegisterViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

enum ValidAction {
	case no
	case source
	case profile
	case all
}

struct AccountRegisterViewData {
	let nickName: String?
	let userName: String
	let email: String
	let firstName: String
	let lastName: String
	let birthDay: String
	let gender: GenderType
	let avatar: (url: String?, data: Data?)
	let weight: Double
	let height: Double
	let blood: BloodType
	let location: (latitude: Double, longitude: Double, address: String)
	let isAgreedTermsOfUse: Bool
}

protocol AccountRegisterViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var info: PublishSubject<AccountRegisterViewData> { get }
	func didTake(avatar: Data)
	func submit() -> Observable<Void>
	func goto(term: TermOfUseViewType)
	
	// MARK: Coordinator - Outputs
	
	// MARK: View - Outputs
	var validAction: Observable<ValidAction> { get }
}
