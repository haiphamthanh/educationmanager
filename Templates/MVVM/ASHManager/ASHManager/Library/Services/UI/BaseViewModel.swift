//
//  BaseViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/2/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BaseViewModel {
	// MARK: - ================================= Properties =================================
	let disposeBag = DisposeBag()
	
	private(set) var model: BaseModelProtocol?
	private(set) var networkService: NetworkServiceProtocol?
	
	private let pDialogMessage: PublishSubject<PageDialogMessage> = PublishSubject<PageDialogMessage>()
	private let pDialogMessageVC: PublishSubject<PageDialogActionMessage<AbstractPopUpOutput>> = PublishSubject<PageDialogActionMessage<AbstractPopUpOutput>>()
	private let pToastMessage: PublishSubject<String> = PublishSubject<String>()
	private let pDataSource: BehaviorSubject<Any?> = BehaviorSubject<Any?>(value: nil)
	
	// MARK: - ================================= Init =================================
	required init(model: BaseModelProtocol,
				  networkService: NetworkServiceProtocol) {
		self.model = model
		self.networkService = networkService
	}
	
	// MARK: - ======================= Use for inherit in subclass =======================
	func initialize(params: Dictionary<String, Any>?) {
		// Implement in subclass
	}
	
	/// This function should be call only one at creation time
	func loadData() {
		// Implement in subclass
	}
	
	
	/// This function should be call every time need to reload data
	func reloadData() -> Observable<Void> {
		return Observable.create({ [weak self] observable -> Disposable in
			self?.resetAll()
			return Disposables.create()
		})
	}
	
	func mergedData() -> Any? {
		return nil
	}
	
	// MARK: - ======================= Use for reload =======================
	private let limitEveryLoad = 10
	var currentOffset = 0
	var totalNumber = 0
	
	func resetAll() {
		currentOffset = 0
	}
	
	func loadMoreData(offset: Int, limit: Int) -> Observable<Void> {
		fatalError("Need to implement in subclass")
	}
	
	// Anchor to didSet data
	final func autoLoadMore() {
		if currentOffset >= limitEveryLoad || !canLoadMore() {
			return refreshData()
		}
		
		return loadMoreData()
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	final func loadMoreData() -> Observable<Void> {
		return loadMoreData(offset: currentOffset, limit: limitEveryLoad)
	}
	
	final func canLoadMore() -> Bool {
		return (totalNumber > currentOffset)
	}
	
	deinit {
		print("\(self) is deinit")
	}
}

// MARK: - ================================= Final =================================
extension BaseViewModel {
	func refreshData() {
		pDataSource.onNext(mergedData())
	}
	
	func refreshDataObs() -> Observable<Void> {
		return Observable.create({ [weak self] observable -> Disposable in
			self?.refreshData()
			return Disposables.create()
		})
	}
}

// MARK: - ================================= BaseViewModelProtocol =================================
extension BaseViewModel: BaseViewModelProtocol {
	func loadMore() -> Observable<Void> {
		return loadMoreData()
	}
	
	var dialogMessage: Observable<PageDialogMessage> {
		return pDialogMessage
	}
	var dialogMessageVC: Observable<PageDialogActionMessage<AbstractPopUpOutput>> {
		return pDialogMessageVC
	}
	var toastMessage: Observable<String> {
		return pToastMessage
	}
	var dataSource: Observable<Any?> {
		return pDataSource
	}
	
	func reload() -> Observable<Void> {
		return reloadData()
	}
	
	func reloadWhenViewWillAppear() {
		
	}
	
	func push(params: Dictionary<String, Any>?) {
		initialize(params: params)
		loadData()
		refreshData()
	}
}

// MARK: - ================================= Dialog && Toast =================================
extension BaseViewModel {
	func showDialog(error: Error, title: String? = nil, action: (() -> Void)? = nil) {
		return showOKDialog(title: title, message: error.localizedDescription, action: action)
	}
	
	func showOKDialog(title: String? = nil, message: String, action: (() -> Void)? = nil) {
		let button = PageDialogButton(title: LocalizedString.localizedString(input: "OK"),
									  action: action)
		let messageDialog = PageDialogMessage(title: title,
											  message: message,
											  buttons: [button])
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
	
	func showToast(message: String) {
		pToastMessage.onNext(message)
	}
}

// MARK: - ================================= Private =================================
private extension BaseViewModel {
	private func showDialog(message: PageDialogMessage) {
		pDialogMessage.onNext(message)
	}
	
	private func showActionDialog(message: PageDialogActionMessage<AbstractPopUpOutput>) {
		pDialogMessageVC.onNext(message)
	}
}
