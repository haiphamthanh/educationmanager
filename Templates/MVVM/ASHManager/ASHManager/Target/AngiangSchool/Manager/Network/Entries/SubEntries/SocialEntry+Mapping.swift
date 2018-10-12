//
//  SocialEntry+Mapping.swift
//  ASHManager
//
//  Created by KhoaLA on 5/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension SocialDataEntry: ImmutableMappable {
	init(map: Map) throws {
		data = try map.value("data")
	}
	
	func toData() -> AuthData {
		return AuthData(role_id: data.roleId, token: data.token, refreshToken: data.refreshToken)
	}
}

extension SocialInfoEntry: ImmutableMappable {
	init(map: Map) throws {
		googleId = (try? map.value("nick_name")) ?? ""
		facebookId = (try? map.value("nick_name")) ?? ""
		username = try map.value("username")
		email = try map.value("email")
		avatar = (try? map.value("avatar")) ?? ""
		roleId = try map.value("role_id")
		token = try map.value("token")
		refreshToken = (try? map.value("refresh_token")) ?? ""
	}
}

