//
//  User+Mapping.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension UserEntry: ImmutableMappable {
	
	// JSON -> Object
	init(map: Map) throws {
		userInfo = try UserInfoEntry.init(map: map)
		health = try HealthEntry.init(map: map)
	}
	
	func toData() -> UserData {
		return UserData(userInfo: userInfo.toData(), health: health.toData())
	}
}
