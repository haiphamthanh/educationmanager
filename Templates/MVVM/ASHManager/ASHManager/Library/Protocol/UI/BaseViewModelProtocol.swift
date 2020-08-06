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
	// MARK: View - Inputs
	var didAlert: AnyObserver<Void> { get }
	func push(params: Dictionary<String, Any>?)
	func reload() -> Observable<Void>
	func loadMore() -> Observable<Void>
	
	// MARK: Coordinator - Outputs
	var didDone: Observable<Void> { get }
	
	// MARK: View - Outputs
	var toast: Observable<String> { get }
	var alert: Observable<AlertInput> { get }
	var dataSource: Observable<Any?> { get } // TODO: Make Any confirm to BaseViewModelProtocol
	func canLoadMore() -> Bool
	
	// MARK: View - Outputs - Don't use directly
	func clone(with newtype: BaseViewModel.Type) -> BaseViewModelProtocol
}
