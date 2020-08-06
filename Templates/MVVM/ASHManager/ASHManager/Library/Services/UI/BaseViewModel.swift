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
	let pDone = PublishSubject<Void>()
	
	private(set) var model: BaseModelProtocol
	private(set) var network: NetworkServiceProtocol
	private(set) var dataStore: DataStoreServiceProtocol
	
	private let pAlert = PublishSubject<AlertInput>()
	private let pdidAlert = PublishSubject<Void>()
	private let pToast = PublishSubject<String>()
	private let pDataSource = BehaviorSubject<Any?>(value: nil)
	
	// MARK: - ================================= Init =================================
	required init(model: BaseModelProtocol,
				  network: NetworkServiceProtocol,
				  dataStore: DataStoreServiceProtocol) {
		self.model = model
		self.network = network
		self.dataStore = dataStore
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
		pDone.onNext(())
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
	var didAlert: AnyObserver<Void> {
		return pdidAlert.asObserver()
	}
	
	func loadMore() -> Observable<Void> {
		return loadMoreData()
	}
	
	var alert: Observable<AlertInput> {
		return pAlert.asObserver()
	}
	var toast: Observable<String> {
		return pToast
	}
	var dataSource: Observable<Any?> {
		return pDataSource
	}
	
	func reload() -> Observable<Void> {
		return reloadData()
	}
	
	func push(params: Dictionary<String, Any>?) {
		initialize(params: params)
		loadData()
		refreshData()
	}
}

// MARK: - ================================= Outputs =================================
extension BaseViewModel {
	var didDone: Observable<Void> {
		return pDone.asObservable()
	}
}

// MARK: - ================================= Dialog && Toast =================================
extension BaseViewModel {
	func showAlert(title: String? = nil, error: Error) -> Observable<Void> {
		return showAlert(title: title, message: error.localizedDescription)
	}
	
	func showAlert(title: String? = nil, message: String) -> Observable<Void> {
		let alerInput = AlertInput(title: title, message: message)
		return showAlertAdapter(alerInput)
	}
	
	func showToast(message: String) {
		pToast.onNext(message)
	}
}

// MARK: - ================================= View - Outputs - Don't use directly =================================
extension BaseViewModel {
	func clone(with newtype: BaseViewModel.Type) -> BaseViewModelProtocol {
		return newtype.init(model: model,
							network: network,
							dataStore: dataStore)
	}
}

// MARK: - ================================= Private =================================
private extension BaseViewModel {
	private func showAlertAdapter(_ input: AlertInput) -> Observable<Void> {
		return showAlert(input)
			.take(1)
	}
	
	private func showAlert(_ input: AlertInput) -> Observable<Void> {
		pAlert.onNext(input)
		return pdidAlert
	}
}
