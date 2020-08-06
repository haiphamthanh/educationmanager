//
//  BaseViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ########################## BASE_VIEW_CONTROLLER ##########################
class BaseViewController: UIViewController {
	// MARK: - ================================= Properties =================================
	private(set) var alert: AlertServiceProtocol!
	private(set) var toast: ToastServiceProtocol!
	private(set) var image: ImageServiceProtocol!
	
	private var viewModel: BaseViewModelProtocol?
	
	let disposeBag = DisposeBag()
	var isNavBarHidden: Bool {
		return false
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
		
		navigationController?.isNavigationBarHidden = isNavBarHidden
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		guard let container = segue.destination as? BaseViewController, let viewModel = viewModel else {
			return
		}
		
		container.initialize(viewModel: viewModel,
							 alert: alert,
							 toast: toast,
							 image: image)
	}
	
	override var prefersHomeIndicatorAutoHidden: Bool {
		return true
	}
	
	/// Use for customization
	/// Config subcribe object view after loadview
	func subcribeSetup() {
		guard let vm = viewModel else { return }
		
		vm.alert
			.share()
			.flatMap(weak: self) { instance, input -> Observable<Void> in
				return instance.showAlert(input)
			}
			.bind(to: vm.didAlert)
			.disposed(by: disposeBag)
		
		vm.toast
			.share()
			.subscribe(onNext: { [weak self] message in
				self?.toast(message)
			})
			.disposed(by: disposeBag)
		
		vm.dataSource
			.share()
			.subscribe(onNext: { [weak self] dataSource in
				self?.configView(with: dataSource)
			})
			.disposed(by: disposeBag)
	}
	
	/// Use for customization
	/// Setup views after loadview
	func setupViews() {
		self.navigationItem.leftBarButtonItems = leftButtons()
		self.navigationItem.rightBarButtonItems = rightButtons()
	}
	
	/// Use for customization
	/// Config to fill data to view
	func configView(with dataSource: Any) {
		// Implement in subclass
		fatalError("Miss implement configView")
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
	func alert(title: String? = nil, message: String) -> Observable<Void> {
		let alertInput = AlertInput(title: title, message: message)
		
		return showAlert(alertInput)
	}
	
	func toast(_ message: String) {
		return toast.show(message: message)
	}
}

// MARK: - ########################## BaseViewProtocol ##########################
extension BaseViewController: BaseViewProtocol {
	func initialize(viewModel: BaseViewModelProtocol,
					alert: AlertServiceProtocol,
					toast: ToastServiceProtocol,
					image: ImageServiceProtocol) {
		self.viewModel = viewModel
		self.alert = alert
		self.toast = toast
		self.image = image
	}
}

// MARK: - ########################## Private ##########################
private extension BaseViewController {
	func configView(with dataSource: Any?) {
		if let dataSource = dataSource {
			configView(with: dataSource)
		}
	}
	
	func showAlert(_ input: AlertInput) -> Observable<Void> {
		return alert.show(input)
	}
}
