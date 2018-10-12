//
//  IntroViewModelDelegate.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol IntroViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: - Inputs
	var signUp: AnyObserver<Void> { get }
	var signIn: AnyObserver<Void> { get }
	
	// MARK: - Outputs
	var didDone: Observable<Void> { get }
	var willSignIn: Observable<Void> { get }
	var willSignUp: Observable<Void> { get }
}
