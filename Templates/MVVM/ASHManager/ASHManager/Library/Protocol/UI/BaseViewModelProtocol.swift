//
//  BaseViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/15/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

///// Need to implement for multiple source later
///// Only need one source for one screen currently
protocol BaseViewModelProtocol: class {
	// For first load
	func push(params: Dictionary<String, Any>?)
	
	// Usage
	var dialogMessage: Observable<PageDialogMessage> { get }
	var dialogMessageVC: Observable<PageDialogActionMessage<AbstractPopUpOutput>> { get }
	var toastMessage: Observable<String> { get }
	var dataSource: Observable<Any?> { get } // TODO: Make Any confirm to BaseViewModelProtocol
	
	func reload() -> Observable<Void>
	func reloadWhenViewWillAppear()
	
	func canLoadMore() -> Bool
	func loadMore() -> Observable<Void>
}
