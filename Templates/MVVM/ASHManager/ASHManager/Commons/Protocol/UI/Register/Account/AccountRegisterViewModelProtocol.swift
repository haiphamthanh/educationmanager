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
	let password: String
	let firstName: String
	let lastName: String
	let birthDay: String
	let gender: GenderType
	let avatar: (url: String, data: Data?)
	let weight: (value: Double, type: WeightType)
	let height: (value: Double, type: HeightType)
	let blood: BloodType
	let systolicPressure: Int
	let diastolicPressure: Int
	let surgery: Surgery
	let feelCondition: FeelCondition
	let smoking: (level: SmokingLevel, frequency: SmokingFrequency)
	let alcohol: (level: AlcoholLevel, frequency: AlcoholFrequency)
	let location: (latitude: String, longitude: String)
	let isAgreedTermsOfUse: Bool
}

struct FitbitParam {
	let code: String
}

struct GobeParam {
	let username: String
	let password: String
}

struct SourceParam<T> {
	let source: HealthSource
	let param: T
	
	init(param: T, source: HealthSource = .apple) {
		self.param = param
		
		switch self.param {
		case is FitbitParam:
			self.source = .fitbit
		case is GobeParam:
			self.source = .gobe
		default:
			self.source = source
		}
	}
}

protocol AccountRegisterViewModelProtocol: ViewModelAdapterProtocol {
	// view to viewmodel
	var info: PublishSubject<AccountRegisterViewData> { get }
	
	// viewmodel to view
	var validAction: Observable<ValidAction> { get }
	
	// Action
	func didTake(avatar: Data)
	func select<T>(sourceParam: SourceParam<T>) -> Observable<Void>
	func submit() -> Observable<Void>
	
	// TermsOfUse
	func goto(term: TermOfUseViewType)
}
