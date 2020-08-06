//
//  BaseViewProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/17/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

protocol BaseViewProtocol: class {
	func initialize(viewModel: BaseViewModelProtocol,
					alert: AlertServiceProtocol,
					toast: ToastServiceProtocol,
					image: ImageServiceProtocol)
}
