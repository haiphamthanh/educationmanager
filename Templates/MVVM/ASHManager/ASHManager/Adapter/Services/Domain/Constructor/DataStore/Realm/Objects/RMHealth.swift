//
//  RMHealth.swift
//  ASHManager
//
//  Created by HaiPT15 on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import QueryKit
import RealmSwift

class RMHealth: Object {
	@objc dynamic var uid: String = UUID().uuidString
	@objc dynamic var height: Double = 0
	@objc dynamic var weight: Double = 0
	@objc dynamic var blood_type: Int = 0
	
	override class func primaryKey() -> String {
		return "uid"
	}
}

extension RMHealth {
	static var uid: Attribute<String> { return Attribute("uid") }
	static var height: Attribute<Double> { return Attribute("height") }
	static var weight: Attribute<Double> { return Attribute("weight") }
	static var blood_type: Attribute<Int> { return Attribute("blood_type") }
}
