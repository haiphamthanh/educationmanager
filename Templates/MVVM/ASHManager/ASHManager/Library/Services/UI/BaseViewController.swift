//
//  BaseViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ########################## BASE_VIEW_CONTROLLER ##########################
class BaseViewController: UIViewController, UINavigationControllerDelegate {
	// MARK: - ================================= Properties =================================
	private(set) var dialogService: PageDialogServiceProtocol?
	private(set) var toastService: ToastServiceProtocol?
	private var viewModel: BaseViewModelProtocol?
	
	let disposeBag = DisposeBag()
	var enableNavigationBar = true {
		didSet {
			navigationController?.isNavigationBarHidden = !enableNavigationBar
		}
	}
	var isCleanBackButtonText: Bool {
		return true
	}
	
	// MARK: - ================================= Use for customization =================================
	override func awakeFromNib() {
		super.awakeFromNib()
		
		title = mainTitle()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		subcribeSetup()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let vm = viewModel else { return }
		
		vm.reloadWhenViewWillAppear()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let container = segue.destination as? BaseViewController {
			guard let viewModel = viewModel, let dialogService = dialogService, let toastService = toastService else { return }
			container.initialize(viewModel: viewModel,
								 dialogService: dialogService,
								 toastService: toastService)
		}
	}
	
	// TODO: Check to remove code or comment
	//	override func viewWillAppear(_ animated: Bool) {
	//		super.viewWillAppear(animated)
	//
	//		navigationController?.isNavigationBarHidden = !enableNavigationBar
	//		navigationController?.navigationBar.alpha = 1
	//	}
	//
	//	override func viewDidLayoutSubviews() {
	//		super.viewDidLayoutSubviews()
	//
	//		if #available(iOS 11, *) { } else {
	//			navigationController?.isNavigationBarHidden = !enableNavigationBar
	//			navigationController?.navigationBar.alpha = 1
	//		}
	//	}
	
	/// Use for customization
	/// Config subcribe object view after loadview
	func subcribeSetup() {
		guard let vm = viewModel else { return }
		
		vm.dialogMessage
			.observeOn(MainScheduler.instance)
			.share()
			.subscribe(onNext: { [weak self] dialogMessage in
				self?.showDialog(message: dialogMessage)
			})
			.disposed(by: disposeBag)
		
		vm.dialogMessageVC
			.observeOn(MainScheduler.instance)
			.share()
			.subscribe(onNext: { [weak self] dialogActionMessage in
				self?.showActionDialog(message: dialogActionMessage)
			})
			.disposed(by: disposeBag)
		
		vm.toastMessage
			.observeOn(MainScheduler.instance)
			.share()
			.subscribe(onNext: { [weak self] toastMessage in
				self?.showToast(message: toastMessage)
			})
			.disposed(by: disposeBag)
		
		vm.dataSource
			.observeOn(MainScheduler.instance)
			.share()
			.subscribe(onNext: { [weak self] dataSource in
				self?.configView(with: dataSource)
			})
			.disposed(by: disposeBag)
	}
	
	/// Use for customization
	/// Setup views after loadview
	func setupViews() {
		navigationController?.delegate = isCleanBackButtonText ? self : nil
		reloadBarButton()
	}
	
	/// Use for customization
	/// Config to fill data to view
	func configView(with dataSource: Any) {
		// Implement in subclass
		fatalError("Miss implement configView")
	}
	
	/// Use for customization
	/// Config to init data before loadview
	func initialize() {
	}
	
	// MARK: - ================================= VIEW SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	
	/// ViewModel
	///
	/// - Important: HOW TO USE
	///
	/// modelWraper(type: AuthViewModelProtocol.self)
	///
	/// with AuthViewModelProtocol IS KIND OF BaseViewModelProtocol
	///
	/// - Parameter type: Protocol base on BaseViewModelProtocol
	/// - Returns: ViewModel base on subclass provided
	func viewModelWraper<T>(type: T.Type) -> T {
		if let viewModel = viewModel as? T {
			return viewModel
		}
		
		fatalError("Miss implement for" + viewModel.debugDescription)
	}
	
	func mainTitle() -> String {
		return ""
	}
	
	class func storyNameProvider() -> String {
		return ""
	}
	
	func rightButtons() -> [UIBarButtonItem]? {
		return []
	}
	
	func leftButtons() -> [UIBarButtonItem]? {
		return []
	}
	
	deinit {
		print("\(self) is deinit")
	}
}

// MARK: - ########################## Final ##########################
extension BaseViewController {
	var isViewModelAvailable: Bool {
		return viewModel != nil
	}
	
	func reloadBarButton() {
		if let rightButtons = rightButtons() {
			navigationItem.setRightBarButtonItems(rightButtons, animated: true)
		}
		
		if let leftButtons = leftButtons() {
			navigationItem.setLeftBarButtonItems(leftButtons, animated: true)
		}
	}
	
	//TODO: HaiPT15
	func showCamera(_ sender: UITapGestureRecognizer) -> Observable<UIImage> {
		//TODO Show camera
		return showSelectPhoto()
	}
	
	func showSelectPhoto(_ sender: UITapGestureRecognizer) -> Observable<UIImage> {
		return showSelectPhoto()
	}
	
	func showSelectPhoto() -> Observable<UIImage> {
		return Observable.create({ [weak self] obserable -> Disposable in
			guard let strongSelf = self else {
				return Observable<UIImage>.never().subscribe()
			}
			
			let action = strongify(self, closure: { (instance, output: AbstractPopUpOutput) in
				guard let output = output as? PhotoPopUpInput else { return }
				obserable.onNext(output.image)
			})
			strongSelf.showActionDialog(vcType: .photoSelection,
										params: nil,
										action: action)
			
			return Disposables.create()
		})
	}
	
	func showOKDialog(title: String? = nil, message: String, action: (() -> Void)? = nil) {
		let button = PageDialogButton(title: LocalizedString.localizedString(input: "OK"),
									  action: action)
		let messageDialog = PageDialogMessage(title: title,
											  message: message,
											  buttons: [button])
		showDialog(message: messageDialog)
	}
	
	func showConfirmDialog(title: String? = nil, message: String,
						   okAction: @escaping (() -> Void),
						   cancelAction: @escaping (() -> Void)) {
		let ok = PageDialogButton(title: LocalizedString.localizedString(input: "OK"), action: okAction)
		let cancel = PageDialogButton(type: .cancel, title: LocalizedString.localizedString(input: "Cancel"), action: cancelAction)
		let messageDialog = PageDialogMessage(title: title,
											  message: message,
											  buttons: [ok, cancel])
		
		showDialog(message: messageDialog)
	}
	
	func showActionDialog(title: String? = nil, message: String? = nil, vcType: PopUpViewControllerType, params: Dictionary<String, Any>?, action: ((AbstractPopUpOutput) -> ())? = nil) {
		let messageDialog = PageDialogActionMessage(type: vcType,
													params: params,
													title: title,
													message: message,
													action: action)
		showActionDialog(message: messageDialog)
	}
	
	func showActionDialogVCOnly(title: String? = nil, message: String? = nil, vcType: PopUpViewControllerType, params: Dictionary<String, Any>?) {
		let messageDialog = PageDialogActionMessage<AbstractPopUpOutput>(type: vcType,
													params: params,
													title: title,
													message: message,
													confirmButtons: false)
		showActionDialog(message: messageDialog)
	}
	
	func showToast(message: String) {
		toastService?.toast(message: message)
	}
}

// MARK: - ########################## BaseViewProtocol ##########################
extension BaseViewController: BaseViewProtocol {
	func initialize(viewModel: BaseViewModelProtocol,
					dialogService: PageDialogServiceProtocol,
					toastService: ToastServiceProtocol) {
		self.viewModel = viewModel
		self.dialogService = dialogService
		self.toastService = toastService
		
		initialize()
	}
}

// MARK: - ########################## Private ##########################
private extension BaseViewController {
	private func configView(with dataSource: Any?) {
		if let dataSource = dataSource {
			configView(with: dataSource)
		}
	}
	
	private func showDialog(message: PageDialogMessage) {
		dialogService?.show(message: message)
	}
	
	private func showActionDialog(message: PageDialogActionMessage<AbstractPopUpOutput>) {
		dialogService?.show(vcType: message.type,
							params: message.params,
							confirmButtons: message.confirmButtons)
	}
}

// MARK: - ########################## SLIDE_MENU ##########################
class BaseSlideMenuViewController: BaseViewController {
	// MARK: +++======== Menu ========+++
	var leftIcon = "ic_menu_black_24dp"
	var rightIcon = "ic_notifications_black_24dp"
	var enableSwipe = true
	var enableRight: Bool {
		return false
	}
	var enableLeft: Bool {
		return false
	}
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configForSlideMenu()
	}
	
	// MARK: - ================================= Private =================================
	private func configForSlideMenu() {
		removeNavigationBarItem()
		
		if enableLeft {
			if enableSwipe {
				slideMenuController()?.addLeftGestures()
			}
			
			addLeftBarButtonWithImage(UIImage(named: leftIcon)!)
		}
		
		if enableRight {
			if enableSwipe {
				slideMenuController()?.addRightGestures()
			}
			
			addRightBarButtonWithImage(UIImage(named: rightIcon)!)
		}
	}
	
	private func removeNavigationBarItem() {
		slideMenuController()?.removeLeftGestures()
		slideMenuController()?.removeRightGestures()
		navigationItem.rightBarButtonItem = nil
	}
}
