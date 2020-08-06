//
//  UserEntry+Mapping.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension UserEntry: ImmutableMappable {
	// JSON -> Object
	init(map: Map) throws {
		uid = try map.value("uid", using: UidTransform())
		userInfo = try map.value("info")
		health = try map.value("health")
	}
}
