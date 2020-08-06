//
//  BaseCoordinatorProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/20/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol BaseCoordinatorProtocol {
	func setup(coorBag: AdapterCoordinator)
	func push(params: Dictionary<String, Any>?)
	func startProcess() -> Observable<Void>
}
