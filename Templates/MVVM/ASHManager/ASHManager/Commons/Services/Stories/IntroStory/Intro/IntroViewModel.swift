//
//  IntroViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class IntroViewModel: ViewModelAdapter {
	// MARK: - Private
	private let _signIn = PublishSubject<Void>()
	private let _signUp  = PublishSubject<Void>()
}

// MARK: - ================================= Inputs =================================
extension IntroViewModel: IntroViewModelProtocol {
	var signUp: AnyObserver<Void> {
		return _signUp.asObserver()
	}
	
	var signIn: AnyObserver<Void> {
		return _signIn.asObserver()
	}
}

// MARK: - ================================= Outputs =================================
extension IntroViewModel {
	var willSignIn: Observable<Void> {
		return _signIn.asObservable()
	}
	
	var willSignUp: Observable<Void> {
		return _signUp.asObservable()
	}
}

// MARK: - ================================= Private =================================
private extension IntroViewModel {
}
