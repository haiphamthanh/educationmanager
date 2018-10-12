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
	private var gobe: (user: String, pass: String)?
	private var fitbit: (accessToken: String, refreshToken: String, expires: Int)?
	private var sourceSelection: HealthSource = .noneApp
	
	// MARK: - ================================= Init =================================
	override func initialize(params: Dictionary<String, Any>?) {
		let basicInfo: AccountRegisterViewData!
		if let params = params, let user = NavigationParameters.getUserUpdating(params: params) {
			basicInfo = AccountRegisterViewData(from: user)
		} else {
			let userInfo = UserInfoData(nickName: nil)
			let user = UserData(userInfo: userInfo)
			basicInfo = AccountRegisterViewData(from: user)
		}
		
		userBasicInfo = basicInfo
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
	
	func select<T>(sourceParam: SourceParam<T>) -> Observable<Void> {
		let successfulMapping = strongify(self, closure: { (instance, info: AccountRegisterViewData) in
			let userData = info.user()
			instance.userBasicInfo = AccountRegisterViewData(from: userData)
		})
		
		return selectSource(sourceParam: sourceParam)
			.map(successfulMapping)
	}
	
	func submit() -> Observable<Void> {
		guard let userBasicInfo = userBasicInfo else {
			return Observable.never()
		}
		
		let user = userBasicInfo.user(from: gobe, or: fitbit)
		
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
	
	func selectSource<T>(sourceParam: SourceParam<T>) -> Observable<AccountRegisterViewData> {
		let type = sourceParam.source
		let param = sourceParam.param
		sourceSelection = type
		
		switch type {
		case .fitbit:
			if let param = param as? FitbitParam {
				return fetchFitbitUserInfo(from: param.code)
			}
		case .gobe:
			return fetchGobeUserInfo()
		case .apple, .smartphone, .googleFit, .noneApp:
			break
		}
		
		return Observable<AccountRegisterViewData>.never()
	}
	
	// MARK: ============== REQUEST DATA ==============
	func fetchFitbitUserInfo(from code: String) -> Observable<AccountRegisterViewData> {
		return gkNetworkService
			.fetchFitbitUserInfo(from: code)
			.map({ AccountRegisterViewData(from: $0) })
	}
	
	func fetchGobeUserInfo() -> Observable<AccountRegisterViewData> {
		return Observable.create({ [weak self] obserable -> Disposable in
			let action = strongify(self, closure: { (instance, output: AbstractPopUpOutput) in
				guard let output = output as? GobePopUpOutput else { return }

				return instance.fetchGobeUserInfo(from: output.userName, password: output.password)
					.subscribe(onNext: { info in
						obserable.onNext(info)
					})
					.disposed(by: instance.disposeBag)
			})

			self?.showActionDialog(vcType: .gobe, params: nil, action: action)
			return Disposables.create()
		})
	}
	
	func fetchGobeUserInfo(from username: String, password: String) -> Observable<AccountRegisterViewData> {
		return gkNetworkService
			.fetchGobeUserInfo(userName: username, password: password)
			.map({ AccountRegisterViewData(from: $0) })
	}
	
	func signUp(from user: UserData) -> Observable<Void> {
		let checking = checkValidToRegister()
		if !checking.isValid {
			if let mssg = checking.error {
				showOKDialog(message: mssg)
			}
			
			return Observable.never()
		}
		
		return signUpValidUser(user)
	}
}

// MARK: - ================================= Validate =================================
private extension AccountRegisterViewModel {
	func setupValidation() {
		info
			.map { [weak self] basicInfo -> (Bool, Bool) in
				guard let strongSelf = self else { return (false, false) }
				
				let sourceValid = strongSelf.sourceSelection != .noneApp
				let basicInfoValid = strongSelf.isError(username: basicInfo.userName,
														password: basicInfo.password,
														email: basicInfo.email,
														firstName: basicInfo.firstName,
														lastName: basicInfo.lastName,
														isAgree: basicInfo.isAgreedTermsOfUse) == nil
				return (sourceValid, basicInfoValid)
			}
			.flatMap(combineValidation)
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	func combineValidation(_ sourceValid: Bool, _ basicInfoValid: Bool) -> Observable<Bool> {
		var actionValid: ValidAction = .source
		if sourceValid {
			actionValid = .profile
		} else if basicInfoValid {
			actionValid = .all
		}
		
		pValidAction.onNext(actionValid)
		
		return Observable.create({ observabe -> Disposable in
			observabe.onNext(basicInfoValid)
			return Disposables.create()
		})
	}
	
	func signUpValidUser(_ user: UserData) -> Observable<Void> {
		let success = strongify(self, closure: { (instance, _: Void) in
			instance.showToast(message: LocalizedString.localizedString(input: "Register_Successfull"))
		})
		
		let error = strongify(self, closure: { (instance, error: Error) in
			instance.showOKDialog(message: LocalizedString.localizedString(input: "Gobe_Error_Title"))
		})
		
		return Observable.create({ [weak self] _ -> Disposable in
			guard let strongSelf = self else {
				return Observable<Void>.never().subscribe()
			}
			
			return strongSelf.gkNetworkService
				.register(user: user)
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: success,
						   onError: error)
		})
	}
	
	func isError(username: String, password: String, email: String,
				 firstName: String, lastName: String, isAgree: Bool) -> String? {
		var mssg: String? = nil
		
		if let message = Validate.isValidAuthInputLength(inputString: username) {
			mssg = message
		} else if let message = Validate.isValidAuthInputLength(inputString: password) {
			mssg = message
		} else if let message = Validate.isValidEmail(email: email) {
			mssg = message
		} else if let message = Validate.isValidOptionalInput(inputString: firstName) {
			mssg = message
		} else if let message = Validate.isValidOptionalInput(inputString: lastName) {
			mssg = message
		} else if let message = Validate.isValidAgreeTermOfUseAndPolicy(isAgree: true) {
			mssg = message
		}
		
		return mssg
	}
	
	func checkValidToRegister() -> (isValid: Bool, error: String?) {
		return (isValid: true, error: nil)
	}
	
//	func isValidBasicInfo(username: String,
//						  password: String,
//						  email: String,
//						  firstName: String,
//						  nickName: String,
//						  lastName: String,
//						  isAgree: Bool) -> String? {
//		// Check ki tu dac biet - RegisterUser_001_E_004
//		if username.hasSpecialCharacters() || nickName.hasSpecialCharacters() {
//			return LocalizedString.networkErrRegisterInputInvalidCharacter()
//		}
//
//		// Check space - RegisterUser_001_E_004
//		if username.containsWhitespace || email.containsWhitespace {
//			return LocalizedString.networkErrRegisterInputInvalidCharacter()
//		}
//		
//		// Check emoiji - RegisterUser_001_E_004
//		if username.containsEmoji || password.containsEmoji || email.containsEmoji ||
//			firstName.containsEmoji || nickName.containsEmoji || lastName.containsEmoji {
//			return LocalizedString.networkErrRegisterInputInvalidCharacter()
//		}
//		
//		// Check user name < 8 - RegisterUser_001_E_002
//		if username.length < 8 {
//			return LocalizedString.networkErrRegisterUserLengh()
//		}
//
//		// Check email empty - RegisterUser_001_E_008
//		if email.isEmpty {
//			return LocalizedString.networkErrRegisterEmailRequired()
//		}
//
//		// Check email format - RegisterUser_001_E_009
//		if let checkEmail = Validate.isValidEmail(email: email){
//			return checkEmail
//		}
//
//		// Check email > 255 - RegisterUser_001_E_010
//		if email.length > 255 {
//			return LocalizedString.networkErrRegisterEmailLenghBetween()
//		}
//
//		if !isUpdateUser() {
//			if password.containsWhitespace {
//				return LocalizedString.networkErrRegisterInputInvalidCharacter()
//			}
//
//			// Check password empty - RegisterUser_001_E_005
//			if password.isEmpty {
//				return LocalizedString.networkErrRegisterPassRequired()
//			}
//
//			// Check password < 8 - RegisterUser_001_E_006
//			if password.length < 8 {
//				return LocalizedString.networkErrRegisterPassLengh()
//			}
//			
//			// Check password > 255 - RegisterUser_001_E_007
//			if password.length > 255 {
//				return LocalizedString.networkErrRegisterPassLenghBetween()
//			}
//		}
//
//		// Check first name > 10 - RegisterUser_001_E_015
//		if firstName.length > 10 {
//			return LocalizedString.networkErrRegisterFirstNameLengh()
//		}
//		
//		// Check last name > 10 - RegisterUser_001_E_006
//		if lastName.length > 10 {
//			return LocalizedString.networkErrRegisterLastNameLengh()
//		}
//
//		// Check first name require
//		if firstName.length == 0 {
//			return LocalizedString.networkErrRegisterRequireFirstName()
//		}
//
//		// Check last name require
//		if lastName.length == 0 {
//			return LocalizedString.networkErrRegisterRequireLastName()
//		}
//
//		// Check user name > 20 - RegisterUser_001_E_003
//		if username.length > 20 {
//			return LocalizedString.networkErrRegisterUserLenghBetween()
//		}
//
//		// Check user name > 20 - RegisterUser_001_E_047
//		if nickName.length > 20 {
//			return LocalizedString.networkErrRegisterNickNameLengh()
//		}
//
//		if let message = Validate.isValidAgreeTermOfUseAndPolicy(isAgree: isAgree) {
//			return message
//		}
//		
//		return nil
//	}
}

extension AccountRegisterViewData {
	init(from user: UserData) {
		let userInfor = user.userInfo
		let health = user.health
		
		self.nickName = userInfor.nickName
		self.userName = userInfor.username
		self.email = userInfor.email
		self.password = userInfor.password
		self.firstName = userInfor.first_name
		self.lastName = userInfor.last_name
		self.birthDay = userInfor.birthday
		self.gender = userInfor.gender
		self.avatar = (url: userInfor.avatar, data: nil)
		self.weight = (value: health.weight, type: health.weight_type)
		self.height = (value: health.height, type: health.height_type)
		self.blood = health.blood_type
		self.systolicPressure = health.blood_pressure_upper
		self.diastolicPressure = health.blood_pressure_under
		self.surgery = health.surgery_status
		self.feelCondition = health.feel_condition
		self.smoking = (level: health.smoking_level, frequency: health.smoking_frequency)
		self.alcohol = (level: health.alcohol_level, frequency: health.drink_frequency)
		self.location = (latitude: userInfor.latitude, longitude: userInfor.longitude)
		self.isAgreedTermsOfUse = false
	}
	
	func user(from gobe: (user: String, pass: String)? = nil,
			  or fitbit: (accessToken: String, refreshToken: String, expires: Int)? = nil) -> UserData {
		let userInfor = UserInfoData(id: -1, role_id: 0,
									 nickName: nickName, username: userName, password: password,
									 email: email, birthday: birthDay, gender: gender,
									 avatar: avatar.url, avatarData: avatar.data,
									 first_name: firstName, last_name: lastName,
									 latitude: location.latitude, longitude: location.longitude,
									 health_flag: true, profile_flag: true, announcement_flag: true,
									 advices_flag: true, contest_notifications_flag: true, email_marketing_setting: true)
		
		let health: HealthData!
		if let gobe = gobe {
			health = healthFrom(gobe: gobe)
		} else if let fitbit = fitbit {
			health = healthFrom(fitbit: fitbit)
		} else {
			health = healthFromNone()
		}
		
		return UserData(userInfo: userInfor, health: health)
	}
	
	private func healthFrom(gobe: (user: String, pass: String)) -> HealthData {
		return HealthData(height: height.value, height_type: height.type,
						  weight: weight.value, weight_type: weight.type,
						  blood_pressure_upper: systolicPressure, blood_pressure_under: diastolicPressure,
						  blood_type: blood, surgery_status: surgery, feel_condition: feelCondition,
						  smoking_level: smoking.level, smoking_frequency: smoking.frequency,
						  alcohol_level: alcohol.level, drink_frequency: alcohol.frequency,
						  gobe_username: gobe.user, gobe_password: gobe.pass, health_source: .gobe)
	}
	
	private func healthFrom(fitbit: (accessToken: String, refreshToken: String, expires: Int)) -> HealthData {
		return HealthData(height: height.value, height_type: height.type,
						  weight: weight.value, weight_type: weight.type,
						  blood_pressure_upper: systolicPressure, blood_pressure_under: diastolicPressure,
						  blood_type: blood, surgery_status: surgery, feel_condition: feelCondition,
						  smoking_level: smoking.level, smoking_frequency: smoking.frequency,
						  alcohol_level: alcohol.level, drink_frequency: alcohol.frequency,
						  fitbit_access_token: fitbit.accessToken, fitbit_refresh_token: fitbit.refreshToken, fitbit_expires_in: fitbit.expires, health_source: .fitbit)
	}
	
	private func healthFromNone() -> HealthData {
		return HealthData(height: height.value, height_type: height.type,
						  weight: weight.value, weight_type: weight.type,
						  blood_pressure_upper: systolicPressure, blood_pressure_under: diastolicPressure,
						  blood_type: blood, surgery_status: surgery, feel_condition: feelCondition,
						  smoking_level: smoking.level, smoking_frequency: smoking.frequency,
						  alcohol_level: alcohol.level, drink_frequency: alcohol.frequency, health_source: .noneApp)
	}
}

// MARK: - ================================= Validate utils =================================
extension String {
	fileprivate var containsWhitespace : Bool {
		return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
	}
	
	fileprivate func hasSpecialCharacters() -> Bool {
		do {
			let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9\\s].*", options: .caseInsensitive)
			if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
				return true
			}
			
		} catch {
			debugPrint(error.localizedDescription)
			return false
		}
		
		return false
	}
	
	fileprivate var isValidEmail : Bool {
		return Validate.isValidEmail(email: self) != nil
	}
	
	fileprivate var containsEmoji: Bool {
		for scalar in unicodeScalars {
			switch scalar.value {
			case 0x1F600...0x1F64F, // Emoticons
			0x1F300...0x1F5FF, // Misc Symbols and Pictographs
			0x1F680...0x1F6FF, // Transport and Map
			0x2600...0x26FF,   // Misc symbols
			0x2700...0x27BF,   // Dingbats
			0xFE00...0xFE0F,   // Variation Selectors
			0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
			0x1F1E6...0x1F1FF: // Flags
				return true
			default:
				continue
			}
		}
		return false
	}
}
