//
//  AuthViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/3/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import GoogleSignIn

class AuthViewModel: ViewModelAdapter {
	// MARK: - ================================= Properties =================================
	private let _cancel = PublishSubject<Void>()
	private let _signedIn = PublishSubject<Dictionary<String, Any>?>()
	private let _signUpNew = PublishSubject<Dictionary<String, Any>?> ()
	private let _forgotPassword = PublishSubject<Void>()
	private let _readTermOfUse = PublishSubject<TermAction>()
	
	private let _isValidResult = PublishSubject<Bool>()
	private let _input = PublishSubject<(userName: String, pass: String, isAgreeTerm: Bool)>()
	
	// Use to show error
	private var password: String?
	private var userName: String?
	private var isAgreeTermOfUse = true {
		didSet {
			refreshData()
		}
	}
	
	// Use to show error
	private var errorMessage: String? = ""
	
	// MARK: - ================================= Init =================================
	override func initialize(params: Dictionary<String, Any>?) {
		super.initialize(params: params)
		
		setupTasks()
	}
	
	override func mergedData() -> Any? {
		return AuthViewData(isAgreeTermOfUse: isAgreeTermOfUse)
	}
	
	// MARK: - ================================= Can customize in subclass =================================
	// MARK: ================ Social login ================
	func login(by userName: String, password: String) -> Observable<Void> {
		fatalError("Implement in subclass")
	}
	
	func loginByFacebook(token: String) -> Observable<Void> {
		fatalError("Implement in subclass")
	}
	
	func loginByGoogle(user: GIDGoogleUser) -> Observable<Void> {
		fatalError("Implement in subclass")
	}
	
	deinit {
		_cancel.onNext(())
	}
}

// MARK: - ================================= AuthViewModelProtocol =================================
extension AuthViewModel: AuthViewModelProtocol {
	// MARK: View - Inputs
	var input: PublishSubject<(userName: String, pass: String, isAgreeTerm: Bool)> {
		return _input
	}
	
	// MARK: View - Action
	var readTermOfUse: AnyObserver<TermAction> {
		return _readTermOfUse.asObserver()
	}
	
	var forgotPassword: AnyObserver<Void> {
		return _forgotPassword.asObserver()
	}
	
	func signIn<T>(with param: LoginParams<T>) {
		return proxylogin(with: param)
			.bind(to: _signedIn)
			.disposed(by: disposeBag)
	}
	
	// MARK: Coordinator - Outputs
	var didCancel: Observable<Void> {
		return _cancel.asObservable()
	}
	
	var isValidResult: Observable<Bool> {
		return _isValidResult
	}
	
	var didSignedIn: Observable<Dictionary<String, Any>?> {
		return _signedIn.asObservable()
	}
	
	var signUpNew: Observable<Dictionary<String, Any>?> {
		return _signUpNew.asObservable()
	}
	
	var didForgotPassword: Observable<Dictionary<String, Any>?> {
		return _forgotPassword
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
			.asObservable()
	}
	
	var wannaReadTermOfUse: Observable<Dictionary<String, Any>?> {
		return _readTermOfUse
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
			.asObservable()
	}
}

// MARK: - ================================= Private =================================
private extension AuthViewModel {
	func setupTasks() {
		validationTask()
	}
	
	// MARK: Tasks ================
	func validationTask() {
		let errorMapping = { (error: String?) -> Bool in
			return error == nil
		}
		
		return _input
			.map({ _ in return "" })
			.map(errorMapping)
			.bind(to: _isValidResult)
			.disposed(by: disposeBag)
	}
	
	func proxylogin<T>(with loginParam: LoginParams<T>) -> Observable<Dictionary<String, Any>?> {
		//		if !isValidation {
		//			return showOKDialog(message: errorMessage!)
		//		}
		//
		let type = loginParam.socialType
		let param = loginParam.param
		
		switch type {
		case .email:
			return loginTask(by: "", password: "")
		case .facebook:
			if let param = param as? CommonParam {
				return loginTask(by: param.token)
			}
		case .google:
			if let param = param as? GoogleParam {
				return loginTask(by: param.user)
			}
		default:
			break
		}
		
		return Observable.never()
	}
	
	func loginTask(by userName: String, password: String) -> Observable<Dictionary<String, Any>?> {
		return login(by: userName, password: password)
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
	}
	
	func loginTask(by fbToken: String) -> Observable<Dictionary<String, Any>?> {
		return loginByFacebook(token: fbToken)
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
	}
	
	func loginTask(by googleUser: GIDGoogleUser) -> Observable<Dictionary<String, Any>?> {
		return loginByGoogle(user: googleUser)
			.map({ _ -> Dictionary<String, Any>? in
				return nil
			})
	}
	
	// MARK: Sub function ================
	func checkInput(userName: String, password: String, isAgreeTerm: Bool) -> String? {
		var errorMessage: String?
		
		if let validEmail = Validate.isValidAuthInputLength(inputString: userName) {
			errorMessage = validEmail
		} else if let validInputLength = Validate.isValidAuthInputLength(inputString: password) {
			errorMessage = validInputLength
		}
		
		return errorMessage
	}
}
