//
//  DelegatedCall.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

struct DelegatedCall<Input> {
	
	private(set) var callback: ((Input) -> Void)?
	
	mutating func delegate<Object : AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
		self.callback = { [weak object] input in
			guard let object = object else { return }
			callback(object, input)
		}
	}
}

struct DelegatedNewCall<Input> {
	
	private(set) var callback: ((Input) -> Observable<Void>)?
	
	mutating func delegate<Object : AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Observable<Void>) {
		self.callback = { [weak object] input in
			guard let object = object else { return Observable<Void>.never() }
			return callback(object, input)
		}
	}
}

// Use for one target
func strongify<Context: AnyObject, Arguments>(_ context: Context?, closure: @escaping (Context, Arguments) -> Void) -> (Arguments) -> Void {
	return { [weak context] arguments in
		guard let strongContext = context else { return }
		closure(strongContext, arguments)
	}
}

// Use for two target
func strongify<Context: AnyObject, Context2: AnyObject, Argument1, Argument2>(_ context: Context?, _ context2: Context2?, closure: @escaping (Context, Context2, Argument1, Argument2) -> Void) -> (Argument1, Argument2) -> Void {
	return { [weak context, weak context2] argument1, argument2 in
		guard let strongContext = context, let strongContext2 = context2 else { return }
		closure(strongContext, strongContext2, argument1, argument2)
	}
}
