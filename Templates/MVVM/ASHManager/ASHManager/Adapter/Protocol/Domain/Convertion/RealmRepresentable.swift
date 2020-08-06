//
//  RealmRepresentable.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
	associatedtype RealmType: DomainConvertibleType
	
	var uid: String { get }
	
	func asRealm() -> RealmType
}
