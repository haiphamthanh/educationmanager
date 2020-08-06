//
//  Observable+Ext.swift
//  ASHManager
//
//  Created by 7i3u7u on 1/27/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

extension Observable where Element: Sequence, Element.Iterator.Element: DomainConvertibleType {
	typealias DomainType = Element.Iterator.Element.DomainType
	
	func mapToDomain() -> Observable<[DomainType]> {
		return map { sequence -> [DomainType] in
			return sequence.mapToDomain()
		}
	}
}

extension Sequence where Iterator.Element: DomainConvertibleType {
	typealias Element = Iterator.Element
	func mapToDomain() -> [Element.DomainType] {
		return map {
			return $0.asDomain()
		}
	}
}

extension ObservableType {
	func flatMap<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.E) throws -> O) -> Observable<O.E> {
		return flatMap { [weak obj] value -> Observable<O.E> in
			try obj.map { try selector($0, value).asObservable() } ?? .empty()
		}
	}
	
	func flatMapFirst<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.E) throws -> O) -> Observable<O.E> {
		return flatMapFirst { [weak obj] value -> Observable<O.E> in
			try obj.map { try selector($0, value).asObservable() } ?? .empty()
		}
	}
	
	func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.E) throws -> O) -> Observable<O.E> {
		return flatMapLatest { [weak obj] value -> Observable<O.E> in
			try obj.map { try selector($0, value).asObservable() } ?? .empty()
		}
	}
}
