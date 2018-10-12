//
//  TermOfUseViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class TermOfUseViewModel: ViewModelAdapter {
	// MARK: - ================================= Properties =================================
	private var termOfUseData = ""
	private var policyData = ""
	
	private let fileType = "txt"
	private let termOfUseFileName = "TermsOfUse"
	private let privacyPolicyFileName = "PrivacyPolicy"
	private var viewType = TermOfUseViewType.termOfUse {
		didSet {
			refreshData()
		}
	}
	
	private var _done = PublishSubject<Void>()
	
	// MARK: - ================================= Init =================================
	override func initialize(params: Dictionary<String, Any>?) {
		termOfUseData = loadData(from: termOfUseFileName, type: fileType)
		policyData = loadData(from: privacyPolicyFileName, type: fileType)
		
		if let params = params, let viewType = NavigationParameters.getTermOfUseFor(params: params) {
			select(view: viewType)
		}
	}
	
	override func mergedData() -> Any? {
		return content(from: viewType)
	}
	
	deinit {
		_done.onNext(())
	}
}

// MARK: - ================================= Final =================================
extension TermOfUseViewModel: TermOfUseViewModelProtocol {
	// MARK: View - Inputs
	var agreeTermOfUse: AnyObserver<Void> {
		return _done.asObserver()
	}
	
	// MARK: View - Action
	func select(view: TermOfUseViewType) {
		viewType = view
	}
	
	// MARK: Coordinator - Outputs
	var understand: Observable<Dictionary<String, Any>?> {
		return _done
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
			.asObservable()
	}
}

// MARK: - ================================= Private =================================
private extension TermOfUseViewModel {
	func loadData(from fileName: String, type: String) -> String {
		guard let filepath = Bundle.main.path(forResource: fileName, ofType: type) else {
			return ""
		}
		
		do {
			let contentData = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
			
			return contentData
		} catch {
			return ""
		}
	}
	
	func content(from type: TermOfUseViewType) -> TermOfUseViewData {
		switch type {
		case .termOfUse:
			return TermOfUseViewData(viewType: type, content: termOfUseData)
		case .policy:
			return TermOfUseViewData(viewType: type, content: policyData)
		}
	}
}
