//
//  AccountRegisterViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class AccountRegisterViewModel: ViewModelAdapter {
	// MARK: - ================================= Properties =================================
	// view to viewmodel
	let info: PublishSubject<AccountRegisterViewData> = PublishSubject<AccountRegisterViewData>()
	
	// private variables
	private var userBasicInfo: AccountRegisterViewData! {
		didSet {
			refreshData()
		}
	}
	private var pValidAction: PublishSubject<ValidAction> = PublishSubject<ValidAction>()
	// other infos
	private var imageData: Data?
	private var password: String = ""
	
	// MARK: - ================================= Init =================================
	override func initialize(params: Dictionary<String, Any>?) {
		//		let basicInfo: AccountRegisterViewData!
		//		if let params = params, let user = NavigationParameters.getUserUpdating(params: params) {
		//			basicInfo = AccountRegisterViewData(from: user)
		//		} else {
		//			let userInfo = UserInfoData(nickName: nil)
		//			let user = UserData(userInfo: userInfo, health: HealthData() (userInfo: userInfo)
		//			basicInfo = AccountRegisterViewData(from: user)
		//		}
		
		//		userBasicInfo = basicInfo
		return setupValidation()
	}
	
	// MARK: - ================================= Config data =================================
	override func mergedData() -> Any? {
		guard let user = userBasicInfo else { return nil }
		
		return user
	}
}

// MARK: - ================================= Final =================================
extension AccountRegisterViewModel: AccountRegisterViewModelProtocol {
	var validAction: Observable<ValidAction> {
		return pValidAction
	}
	
	func didTake(avatar: Data) {
		imageData = avatar
	}
	
	func submit() -> Observable<Void> {
		guard let userBasicInfo = userBasicInfo else {
			return Observable.never()
		}
		
		let user = userBasicInfo.userData()
		return signUp(from: user)
			.flatMap(didSignUp)
	}
	
	func goto(term: TermOfUseViewType) {
		switch term {
		case .policy:
			gotoPolicy()
		case .termOfUse:
			gotoTermOfUse()
		}
	}
}

// MARK: - ================================= Private =================================
private extension AccountRegisterViewModel {
	func gotoPolicy() {
		//		coordinator
		//			.gotoTermOfUse(params: nil)
		//			.subscribe()
		//			.dispose()
	}
	
	func gotoTermOfUse() {
		//		coordinator
		//			.gotoTermOfUse(params: nil)
		//			.subscribe()
		//			.dispose()
	}
	
	func didSignUp() -> Observable<Void> {
		//		return coordinator.didSignUp(params: nil)
		return Observable.never()
	}
	
	// MARK: ============== REQUEST DATA ==============
	func signUp(from user: UserData) -> Observable<Void> {
		let checking = checkValidToRegister()
		if !checking.isValid {
			return showAlert(message: checking.error!)
		}
		
		return signUpValidUser(user).map({ _ in })
	}
}

// MARK: - ================================= Validate =================================
private extension AccountRegisterViewModel {
	func setupValidation() {
		info
			.map { [weak self] basicInfo -> (Bool) in
				guard let strongSelf = self, let password = self?.password  else {
					return false
				}
				
				let basicInfoValid = strongSelf.isError(username: basicInfo.userName,
														password: password,
														email: basicInfo.email,
														firstName: basicInfo.firstName,
														lastName: basicInfo.lastName,
														isAgree: basicInfo.isAgreedTermsOfUse) == nil
				return basicInfoValid
			}
			.flatMap(combineValidation)
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	func combineValidation(_ basicInfoValid: Bool) -> Observable<Bool> {
		pValidAction.onNext(.all)
		
		return Observable.create({ observabe -> Disposable in
			observabe.onNext(basicInfoValid)
			return Disposables.create()
		})
	}
	
	func signUpValidUser(_ user: UserData) -> Observable<UserData> {
		let input = InNWUserRegister(user, imageData, password)
		let out = network.register(input: input)
		
		let _ = out.requestId
		let result = out.result
		
		return result
	}
	
	func isError(username: String, password: String, email: String,
				 firstName: String, lastName: String, isAgree: Bool) -> String? {
		var mssg: String? = nil
		
		return mssg
	}
	
	func checkValidToRegister() -> (isValid: Bool, error: String?) {
		return (isValid: true, error: nil)
	}
}

extension AccountRegisterViewData {
	init(from user: UserData) {
		let userInfor = user.userInfo
		let health = user.health
		
		self.nickName = userInfor.nickName
		self.userName = userInfor.username
		self.email = userInfor.email
		self.firstName = userInfor.first_name
		self.lastName = userInfor.last_name
		self.birthDay = userInfor.birthday
		self.gender = userInfor.gender
		self.avatar = (url: userInfor.avatar, data: nil)
		self.weight = health.weight
		self.height = health.height
		self.blood = health.blood_type
		self.location = (latitude: userInfor.latitude, longitude: userInfor.longitude, address: userInfor.address)
		self.isAgreedTermsOfUse = false
	}
	
	func userData() -> UserData {
		let uid = "-1"
		let userInfor = UserInfoData(uid: uid,
									 role_id: -1,
									 nickName: nickName,
									 username: userName,
									 email: email,
									 birthday: birthDay,
									 gender: gender,
									 avatar: avatar.url,
									 picture: avatar.data,
									 first_name: firstName,
									 last_name: lastName,
									 latitude: location.latitude,
									 longitude: location.longitude,
									 address: location.address,
									 token: "",
									 refreshToken: "",
									 expiry: 0,
									 created_at: 0,
									 updated_at: 0)
		
		let health: HealthData = HealthData(uid: uid, height: height, weight: weight, blood_type: blood)
		
		return UserData(uid: uid, userInfo: userInfor, health: health)
	}
}
