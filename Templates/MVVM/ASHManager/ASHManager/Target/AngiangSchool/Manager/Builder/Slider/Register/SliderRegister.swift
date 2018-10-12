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
	private weak var bloodpresureView: BasicInforBloodPressureVC!
	private weak var sourceSelectedView: BasicInforSourceSelectionVC!
	private weak var profileView: BasicInforProfileVC!
	private weak var birthdayView: BasicInforBirthdayVC!
	private weak var nicknameView: BasicInforNickNameVC!
	private weak var avatarView: BasicInforAvatarVC!
	private weak var alcoholView: BasicInforAlcoholVC!
	private weak var tabaccoView: BasicInforTabacoVC!
	private weak var surgeryView: BasicInforSurgeryVC!
	private weak var healthyInfoView: BasicInforHealthyInfoVC!
	private weak var finishView: BasicInforFinishVC!
	
	private let location: Observable<(latitude: String, longitude: String)> = PublishSubject<(latitude: String, longitude: String)>()
	private lazy var fitbitVC = Config.requestFitbitCode(delegate: self)
	
	private let fitbitObser: PublishSubject<Void> = PublishSubject<Void>()
	
	// MARK: - ======================================== Properties ========================================
	private var viewModel: AccountRegisterViewModelProtocol {
		return viewModelWraper(type: AccountRegisterViewModelProtocol.self)
	}
	
	// MARK: - ======================================== Init ========================================
	required init(in vc: SliderPresentationViewController) {
		super.init(in: vc)
		
		NotificationCenter.default.addObserver(self,
											   selector: Selector(("requestFitbitToken:")),
											   name: NSNotification.Name(rawValue: "FitbitCode"),
											   object: nil)
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
//		var listPages = [EAIntroPage]()
//		let pages = loadSliderPageFromVCs()
//
//		for page in pages {
//			listPages.append(EAIntroPage.init(customView: page))
//		}
//
//		return listPages
		
		var listPages = [EAIntroPage]()
		
		// MARK: ========= PROFILE ==================
		let intro1 = Intro.loadNib()
		intro1.configView(bgImage: "Intro_bg1",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct())
		let intro2 = Intro.loadNib()
		intro2.configView(bgImage: "Intro_bg2",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct1())
		let intro3 = Intro.loadNib()
		intro3.configView(bgImage: "Intro_bg3",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct2())
		let intro4 = Intro.loadNib()
		intro4.configView(bgImage: "Intro_bg4",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct3())
		let intro5 = Intro.loadNib()
		intro5.configView(bgImage: "Intro_bg5",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct4())
		let intro6 = Intro.loadNib()
		intro6.configView(bgImage: "Intro_bg6",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct5())
		intro6.configView(introTitleTextColor: nil, contentTitleTextColor: .darkGray, contentIntroTextColor: .black)
		intro6.configIntroShadow()
		let pages = [intro1, intro2, intro3, intro4, intro5, intro6]
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
	
	// Driver
	func selectSource(_ source: HealthSource) -> Observable<Void>{
		switch source {
		case .fitbit:
			return directToFitbit()
		default:
			return selectOther(source: source)
		}
	}
	
	// Fitbit action
	func requestFitbitToken(_ noti: Notification) {
		guard let userInfo = noti.userInfo, let code = userInfo["FitbitCode"] as? String else {
			return
		}
		
		let completion = strongify(self, closure: { (instance, _: Void) in
			return instance
				.selectFitbitSource(with: code)
				.bind(to: instance.fitbitObser)
				.dispose()
		})
		
		return fitbitVC.dismiss(animated: true, completion: completion)
	}
	
	// Reload view to loaded data
	func configUserInfo(_ profileInfo: BasicInforProfileData) {
//		profileView.selected(profile: profileInfo)
	}
}

// MARK: - ================================= Don't use these directly =================================
private extension SliderRegister {
	// Provide pages for view
	func loadSliderPageFromVCs() -> [GKSliderPageView] {
		genderView = BasicInforGenderVC.newInstance()
		heightView = BasicInforHeightVC.newInstance()
		weightView = BasicInforWeightVC.newInstance()
		bloodView = BasicInforBloodVC.newInstance()
		bloodpresureView = BasicInforBloodPressureVC.newInstance()
		sourceSelectedView = BasicInforSourceSelectionVC.newInstance()
		profileView = BasicInforProfileVC.newInstance()
		birthdayView = BasicInforBirthdayVC.newInstance()
		nicknameView = BasicInforNickNameVC.newInstance()
		avatarView = BasicInforAvatarVC.newInstance()
		alcoholView = BasicInforAlcoholVC.newInstance()
		tabaccoView = BasicInforTabacoVC.newInstance()
		surgeryView = BasicInforSurgeryVC.newInstance()
		healthyInfoView = BasicInforHealthyInfoVC.newInstance()
		finishView = BasicInforFinishVC.newInstance()
		
		// Provide views for slider
		let pageVCs: [AbstractBasicInforVC] = [sourceSelectedView, birthdayView, genderView, weightView, heightView,
											   bloodView, bloodpresureView, alcoholView, tabaccoView, surgeryView,
											   healthyInfoView, nicknameView, avatarView, profileView, finishView]
		var pages = [GKSliderPageView]()
		for item in pageVCs {
			let page = GKSliderPageView()
			page.add(vc: item)
			pages.append(page)
		}
		
		return pages
	}
	
	// Setup validation for pages
	func setupSubcribing() {
		// Binding data ==================
		func setupBindingData() {
			typealias ProfInput = (nick: String, prof: BasicInforProfileData, birth: String, gender: GenderType, image: Data,
				location: (latitude: String, longitude: String))
			typealias HealthInput = (weight: Double, height: Double,
				blood: BloodType, surgery: Surgery, feelCondition: FeelCondition,
				pressure: (systolicUp: Int, diastolicDown: Int),
				tabaco: (level: SmokingLevel, frequency: SmokingFrequency),
				alcohol: (level: AlcoholLevel, frequency: AlcoholFrequency))
			
			let profileCombine = Observable.combineLatest(nicknameView.nickName,
														  profileView.basicInforProfile,
														  birthdayView.birthDay,
														  genderView.gender,
														  avatarView.imageSelected,
														  location)
			
			let healthCombine = Observable.combineLatest(weightView.weight,
														 heightView.height,
														 bloodView.bloodType,
														 surgeryView.surgery,
														 healthyInfoView.feelCondition,
														 bloodpresureView.bloodPresure,
														 tabaccoView.tabaco,
														 alcoholView.alcohol)
			
			let userCombineResult = { (profile: ProfInput, health: HealthInput) -> AccountRegisterViewData in
				let prof = profile.prof
				return AccountRegisterViewData(nickName: profile.nick,
												userName: prof.userName,
												email: prof.email,
												password: prof.password,
												firstName: prof.firstName,
												lastName: prof.lastName,
												birthDay: profile.birth,
												gender: profile.gender,
												avatar: (url: "", data: profile.image),
												weight: (value: health.weight, type: .kg),
												height: (value: health.height, type: .cm),
												blood: health.blood,
												systolicPressure: health.pressure.systolicUp,
												diastolicPressure: health.pressure.diastolicDown,
												surgery: health.surgery,
												feelCondition: health.feelCondition,
												smoking: health.tabaco,
												alcohol: health.alcohol,
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
			
			// DEVICE SELECTION ==================
			sourceSelectedView.sourceSelected
				.flatMap(selectSource)
				.subscribe(onNext: skip)
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
	
	func selectFitbitSource(with code: String) -> Observable<Void> {
		let param = SourceParam<FitbitParam>(param: FitbitParam(code: code))
		return select(sourceParam: param)
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
	func directToFitbit() -> Observable<Void> {
		vc.present(fitbitVC, animated: true, completion: nil)
		
		return fitbitObser
	}
	
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
	
	func select<T>(sourceParam: SourceParam<T>) -> Observable<Void> {
		return viewModel.select(sourceParam: sourceParam)
	}
	
	func submit() -> Observable<Void> {
		return viewModel.submit()
	}
	
	func selectOther(source: HealthSource) -> Observable<Void> {
		let param = SourceParam<Void>(param: (), source: source)
		return viewModel.select(sourceParam: param)
	}
	
	func readTermOfUse(_ term: TermOfUseViewType) {
		presentView?.endEditing(true)
		return viewModel.goto(term: term)
	}
}
