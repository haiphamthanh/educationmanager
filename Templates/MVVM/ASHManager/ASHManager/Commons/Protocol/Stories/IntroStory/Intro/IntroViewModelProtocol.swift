//
//  IntroViewModelDelegate.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

protocol IntroViewModelProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var signUp: AnyObserver<Void> { get }
	var signIn: AnyObserver<Void> { get }
	
	// MARK: Coordinator - Outputs
	var willSignIn: Observable<Void> { get }
	var willSignUp: Observable<Void> { get }
}
