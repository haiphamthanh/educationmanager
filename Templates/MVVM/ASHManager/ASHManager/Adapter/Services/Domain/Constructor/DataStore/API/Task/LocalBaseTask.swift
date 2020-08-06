//
//  LocalBaseTask.swift
//  ASHManager
//
//  Created by 7i3u7u on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//


import CocoaLumberjack
import RealmSwift
import RxSwift

class LocalBaseTask<T: RealmRepresentable> where T == T.RealmType.DomainType, T.RealmType: Object {
	private(set) var repository: Repository<T>
	private let configuration: Realm.Configuration
	
	func execute() -> Observable<[T]> {
		fatalError("Need implement in subclass")
	}
	
	init(configuration: Realm.Configuration = Realm.Configuration()) {
		self.configuration = configuration
		self.repository = Repository<T>(configuration: configuration)
	}
	
	func rxDDLogWarn(_ message: @autoclosure () -> String) -> Observable<[T]> {
		DDLogWarn(message)
		
		return Observable.never()
	}
}
