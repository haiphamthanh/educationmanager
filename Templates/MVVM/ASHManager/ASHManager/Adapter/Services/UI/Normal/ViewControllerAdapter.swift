//
//  ViewControllerAdapter.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ViewControllerAdapter: BaseViewController {
	// MARK: - ================================= Init view =================================
	/// Use for customization
	var isGradientBg: Bool {
		return false
	}
	
	override func setupViews() {
		super.setupViews()
		
		setupSubviews()
	}
}

// MARK: - ================================= Final =================================
extension ViewControllerAdapter: ViewAdapterProtocol {
	func reload() {
		viewModel
			.reload()
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	func reloadObser() -> Observable<Void> {
		return viewModel.reload()
	}
	
	func loadmoreObs() -> Observable<Void> {
		return viewModel.loadMore()
	}
}

// MARK: - ================================= Private =================================
private extension ViewControllerAdapter {
	private var viewModel: ViewModelAdapterProtocol {
		return viewModelWraper(type: ViewModelAdapterProtocol.self)
	}
	
	func setupSubviews() {
		if isGradientBg {
			view.addGradient()
		}
	}
}
