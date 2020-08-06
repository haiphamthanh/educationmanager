//
//  UserInfoEntry.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import ObjectMapper

extension UserInfoEntry: ImmutableMappable {
	// JSON -> Object
	init(map: Map) throws {
		uid = try map.value("uid", using: UidTransform())
		nickName = try? map.value("nickName")
		username = try map.value("username")
		role_id = try map.value("role_id")
		email = try map.value("email")
		birthday = try map.value("birthday")
		gender = try map.value("gender")
		avatar = try? map.value("avatar")
		picture = nil
		first_name = try map.value("first_name")
		last_name = try map.value("last_name")
		latitude = try map.value("latitude")
		longitude = try map.value("longitude")
		address = try map.value("address")
		token = try map.value("token")
		expiry = try map.value("expiry")
		refreshToken = try map.value("refreshToken")
		created_at = try map.value("created_at")
		updated_at = try map.value("updated_at")
	}
}
