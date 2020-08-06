//
//  RMUserInfo.swift
//  ASHManager
//
//  Created by HaiPT15 on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import QueryKit
import RealmSwift

class RMUserInfo: Object {
	@objc dynamic var uid: String = UUID().uuidString
	@objc dynamic var nickName: String? = ""
	@objc dynamic var username: String = ""
	@objc dynamic var role_id: Int = 0
	@objc dynamic var email: String = ""
	@objc dynamic var birthday: String = ""
	@objc dynamic var gender: Int = 0
	@objc dynamic var avatar: String? = ""
	@objc dynamic var picture: Data? = nil
	@objc dynamic var first_name: String = ""
	@objc dynamic var last_name: String = ""
	@objc dynamic var latitude: Double = 0
	@objc dynamic var longitude: Double = 0
	@objc dynamic var address: String = ""
	@objc dynamic var token: String = ""
	@objc dynamic var refreshToken: String = ""
	@objc dynamic var expiry: Double = 0
	@objc dynamic var created_at: Double = 0
	@objc dynamic var updated_at: Double = 0
	
	override class func primaryKey() -> String {
		return "uid"
	}
}

extension RMUserInfo {
	static var uid: Attribute<String> { return Attribute("uid") }
	static var nickName: Attribute<String> { return Attribute("nickName") }
	static var username: Attribute<String> { return Attribute("username") }
	static var role_id: Attribute<Int> { return Attribute("role_id") }
	static var email: Attribute<String> { return Attribute("email") }
	static var birthday: Attribute<String> { return Attribute("birthday") }
	static var gender: Attribute<Int> { return Attribute("gender") }
	static var avatar: Attribute<String> { return Attribute("avatar") }
	static var picture: Attribute<Data> { return Attribute("picture") }
	static var first_name: Attribute<String> { return Attribute("first_name") }
	static var last_name: Attribute<String> { return Attribute("last_name") }
	static var latitude: Attribute<Double> { return Attribute("latitude") }
	static var longitude: Attribute<Double> { return Attribute("longitude") }
	static var address: Attribute<String> { return Attribute("address") }
	static var token: Attribute<String> { return Attribute("token") }
	static var refreshToken: Attribute<String> { return Attribute("refreshToken") }
	static var expiry: Attribute<Double> { return Attribute("expiry") }
	static var created_at: Attribute<Double> { return Attribute("created_at") }
	static var updated_at: Attribute<Double> { return Attribute("updated_at") }
}
