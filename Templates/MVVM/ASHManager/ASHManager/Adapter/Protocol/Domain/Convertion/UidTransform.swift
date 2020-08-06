//
//  UidTransform.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import ObjectMapper

class UidTransform: TransformType {
	
	typealias Object = String
	typealias JSON = Int
	
	init() {}
	
	func transformFromJSON(_ value: Any?) -> String? {
		if let uidInt = value as? Int {
			return String(uidInt)
		}
		
		if let uidStr = value as? String {
			return uidStr
		}
		
		return nil
	}
	
	func transformToJSON(_ value: String?) -> Int? {
		if let uid = value {
			return Int(uid)
		}
		return nil
	}
}
