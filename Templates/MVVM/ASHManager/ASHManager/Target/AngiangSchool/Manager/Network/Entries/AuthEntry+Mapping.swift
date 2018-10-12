//
//  Auth.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension AuthEntry: ImmutableMappable {
	
	// JSON -> Object
	init(map: Map) throws {
		role_id = (try? map.value("role_id")) ?? 0
		token = try map.value("token")
		refreshToken = try map.value("refresh_token")
	}
	
	func toData() -> AuthData {
		return AuthData(role_id: role_id, token: token, refreshToken: refreshToken)
	}
}
