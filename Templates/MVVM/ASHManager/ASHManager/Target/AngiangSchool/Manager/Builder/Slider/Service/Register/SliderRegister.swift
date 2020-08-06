//
//  SliderRegister.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import EAIntroView

class SliderRegister: AbstractSlider {
	// MARK: - ======================================== Outlet ========================================
	private weak var heightView: BasicInforHeightVC!
	private weak var weightView: BasicInforWeightVC!
	private weak var bloodView: BasicInforBloodVC!
	private weak var genderView: BasicInforGenderVC!
	private weak var profileView: BasicInforProfileVC!
	private weak var birthdayView: BasicInforBirthdayVC!
	private weak var nicknameView: BasicInforNickNameVC!
	private weak var avatarView: BasicInforAvatarVC!
	private weak var finishView: BasicInforFinishVC!
	
	private let location = PublishSubject<(latitude: Double, longitude: Double, address: String)>()
	
	// MARK: - ======================================== Properties ========================================
	private var viewModel: AccountRegisterViewModelProtocol {
		return viewModelWraper(type: AccountRegisterViewModelProtocol.self)
	}
	
	// MARK: - ======================================== Init ========================================
	override func sliderDidSet() {
		setupTasks()
	}
	
	// MARK: - ======================================== Config views ========================================
	override var minimumPageMargin: CGFloat {
		return 1.0
	}
	
	override func listPagesBuilder() -> [EAIntroPage] {
		return listPagesProvider()
	}
	
	// MARK: - ================================= EAIntroDelegate =================================
	override func intro(_ introView: EAIntroView!, pageAppeared page: EAIntroPage!, with pageIndex: UInt) {
		super.intro(introView, pageAppeared: page, with: pageIndex)
		
		vc.enableBackButton(enable: pageIndex == 0)
		if pageIndex == 0 {
			introView.scrollView.restrictionArea = CGRect(x: 0,
														  y: 0,
														  width: CGFloat(pageIndex + 1) * introView.scrollView.bounds.size.width,
														  height: introView.scrollView.bounds.size.height)
		}
	}
	
	final override func configView(with dataSource: Any) {
		if let dataSource = dataSource as? AccountRegisterViewData {
			let userInfo = BasicInforProfileData(userName: dataSource.userName,
												 email: dataSource.email,
												 password: "",
												 firstName: dataSource.firstName,
												 lastName: dataSource.lastName,
												 isAgreeTermOfUse: dataSource.isAgreedTermsOfUse)
			configUserInfo(userInfo)
		}
	}
}

// MARK: - ================================= For using =================================
private extension SliderRegister {
	// ============ Getter ============
	func listPagesProvider() -> [EAIntroPage] {
		var listPages = [EAIntroPage]()
		let pages = loadSliderPageFromVCs()
		
		for page in pages {
			listPages.append(EAIntroPage.init(customView: page))
		}
		
		return listPages
	}
	
	// ============ Action ============
	// Setups
	func setupTasks() {
		//		setupSubcribing()
		//		setUpScrollAction()
	}
	
	// Reload view to loaded data
	func configUserInfo(_ profileInfo: BasicInforProfileData) {
		//		profileView.selected(profile: profileInfo)
	}
}

// MARK: - ================================= Don't use these directly =================================
private extension SliderRegister {
	// Provide pages for view
	func loadSliderPageFromVCs() -> [UIView] {
		genderView = BasicInforGenderVC.newInstance()
		heightView = BasicInforHeightVC.newInstance()
		weightView = BasicInforWeightVC.newInstance()
		bloodView = BasicInforBloodVC.newInstance()
		profileView = BasicInforProfileVC.newInstance()
		birthdayView = BasicInforBirthdayVC.newInstance()
		nicknameView = BasicInforNickNameVC.newInstance()
		avatarView = BasicInforAvatarVC.newInstance()
		finishView = BasicInforFinishVC.newInstance()
		
		// Provide views for slider
		let pageVCs: [AbstractBasicInforVC] = [birthdayView, genderView, weightView, heightView,
											   bloodView, nicknameView, avatarView, profileView, finishView]
		var pages = [UIView]()
		for item in pageVCs {
			pages.append(item.view)
		}
		
		return pages
	}
	
	// Setup validation for pages
	func setupSubcribing() {
		// Binding data ==================
		func setupBindingData() {
			typealias ProfInput = (nick: String, prof: BasicInforProfileData, birth: String, gender: GenderType, image: Data,
				location: (latitude: Double, longitude: Double, address: String))
			typealias HealthInput = (weight: Double, height: Double,
				blood: BloodType)
			
			let profileCombine = Observable.combineLatest(nicknameView.nickName,
														  profileView.basicInforProfile,
														  birthdayView.birthDay,
														  genderView.gender,
														  avatarView.imageSelected,
														  location)
			
			let healthCombine = Observable.combineLatest(weightView.weight,
														 heightView.height,
														 bloodView.bloodType)
			
			let userCombineResult = { (profile: ProfInput, health: HealthInput) -> AccountRegisterViewData in
				let prof = profile.prof
				
				return AccountRegisterViewData(nickName: profile.nick,
											   userName: prof.userName,
											   email: prof.email,
											   firstName: prof.firstName,
											   lastName: prof.lastName,
											   birthDay: profile.birth,
											   gender: profile.gender,
											   avatar: (url: "", data: profile.image),
											   weight: health.weight,
											   height: health.height,
											   blood: health.blood,
											   location: profile.location,
											   isAgreedTermsOfUse: prof.isAgreeTermOfUse)
			}
			
			return Observable.combineLatest(profileCombine, healthCombine, resultSelector: userCombineResult)
				.bind(to: viewModel.info)
				.disposed(by: disposeBag)
		}
		setupBindingData()
		
		// Action ==================
		func setupAction() {
			// PROFILE ==================
			profileView.termOfUseDidTap
				.subscribe(onNext: readTermOfUse)
				.disposed(by: disposeBag)
			
			// FINISH ==================
			finishView.registerButton
				.rx
				.tap
				.subscribe(onNext: submitAction)
				.disposed(by: disposeBag)
		}
		setupAction()
	}
	
	func setupScrollingValidation(_ validation: ValidAction) {
		switch validation {
		case .no:
			enableSlidePage(false)
		case .source:
			return limit(at: 1)
		case .profile:
			return limit(at: 14)
		case .all:
			return noLimit()
		}
	}
	
	func submitAction() {
		let success = strongify(self, closure: { (instance, _: Void) in
			instance.finishRegister(on: nil)
		})
		
		let error = strongify(self, closure: { (instance, error: Error) in
			instance.finishRegister(on: error)
		})
		
		enableSlidePage(false)
		return finishView.startProcess()
			.flatMap(submit)
			.subscribe(onNext: success, onError: error)
			.disposed(by: disposeBag)
	}
	
	// Function in cell ==================
	func finishRegister(on error: Error?) {
		let processingError = strongify(self, closure: { (instance, _: Void) in
			instance.enableSlidePage(true)
		})
		
		let completion = strongify(self, closure: { (instance, _: Void) in
			//			instance.completeRegister()
		})
		
		let processDefine = (error: processingError, completion: completion)
		if error != nil {
			return finishView.process(error: processDefine.error)
		}
		
		return finishView.process(success: processDefine.completion)
	}
	
	// Intergrate to view model ==================
	func setUpScrollAction() {
		return viewModel
			.validAction
			.subscribe(onNext: setupScrollingValidation)
			.disposed(by: disposeBag)
	}
	
	func didTake(avatar: Data) {
		return viewModel.didTake(avatar: avatar)
	}
	
	func submit() -> Observable<Void> {
		return viewModel.submit()
	}
	
	func readTermOfUse(_ term: TermOfUseViewType) {
		presentView?.endEditing(true)
		return viewModel.goto(term: term)
	}
}
