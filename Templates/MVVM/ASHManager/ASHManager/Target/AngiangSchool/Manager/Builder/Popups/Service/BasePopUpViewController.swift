//
//  BasePopUpViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol PopUpInputProtocol {
	associatedtype In
	func push(value: In?)
}

protocol PopUpOutputProtocol {
	associatedtype Out
	func asOutput() -> Out
}

class BasePopUpViewController<I: PopUpInputProtocol, O: PopUpOutputProtocol>: UIViewController {
	private var input: I?
	private var pOutput = PublishSubject<O>()
	
	// MARK: - ================================= Action =================================
	
	
	// MARK: - ================================= Customize =================================
	/// Config view for input data
	///
	func configView(input: I?) {
		fatalError("Implement in subclass")
	}
	
	/// Output data
	///
	func output() -> O? {
		fatalError("Implement in subclass")
	}
}

extension BasePopUpViewController {
	var response: Observable<O> {
		return pOutput.asObserver()
	}
	
	/// Call for callback ok action
	///
	func push(input: I? = nil) {
		self.input = input
		
		return configView(input: input)
	}
	
	/// Use for ok action
	///
	func ok() {
		guard let output = output() else {
			return
		}
		
		pOutput.onNext(output)
	}
}
