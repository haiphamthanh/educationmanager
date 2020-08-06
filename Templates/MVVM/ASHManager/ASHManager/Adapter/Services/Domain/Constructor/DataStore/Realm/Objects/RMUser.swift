//
//  RMUser.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/12/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import QueryKit
import RealmSwift

final class RMUser: Object {
	@objc dynamic var uid: String = UUID().uuidString
	@objc dynamic var userInfo: RMUserInfo?
	@objc dynamic var health: RMHealth?
	
	override class func primaryKey() -> String {
		return "uid"
	}
}

extension RMUser {
	static var uid: Attribute<String> { return Attribute("uid") }
	static var userInfo: Attribute<RMUserInfo> { return Attribute("userInfo") }
	static var health: Attribute<RMHealth> { return Attribute("health") }
}
