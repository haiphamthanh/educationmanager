//
//  Fitbit+Mapping.swift
//  ASHManager
//
//  Created by TienNT12 on 4/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension FitbitEntry: ImmutableMappable {
	init(map: Map) throws {
		refresh_token = try map.value("refresh_token")
		scope = try map.value("scope")
		user_id = try map.value("user_id")
		expires_in = try map.value("expires_in")
		access_token = try map.value("access_token")
		token_type = try map.value("token_type")
	}
	
	func toData() -> FitbitData {
		return FitbitData(refresh_token: refresh_token,
						   scope: scope,
						   user_id: user_id,
						   expires_in: expires_in,
						   access_token: access_token,
						   token_type: token_type)
	}
}

struct FitbitUser: ImmutableMappable {
	let info: FitbitUserInfo
	init(map: Map) throws {
		info = try map.value("user")
	}
}

extension FitbitUserInfo: ImmutableMappable {
	init(map: Map) throws {
		age = (try? map.value("age")) ?? 0
		country = (try? map.value("country")) ?? ""
		dateOfBirth = (try? map.value("dateOfBirth")) ?? ""
		displayName = (try? map.value("displayName")) ?? ""
		displayNameSetting = (try? map.value("displayNameSetting")) ?? ""
		encodedId = try map.value("encodedId")
		firstName = (try? map.value("firstName")) ?? ""
		fullName = (try? map.value("fullName")) ?? ""
		lastName = (try? map.value("lastName")) ?? ""
		gender = (try? map.value("gender")) ?? ""
		height = (try? map.value("height")) ?? 0
		weight = (try? map.value("weight")) ?? 0
		locale = (try? map.value("locale")) ?? ""
		memberSince = (try? map.value("memberSince")) ?? ""
		timezone = (try? map.value("timezone")) ?? ""
		avatar = (try? map.value("avatar")) ?? ""
	}
	
	func toData() -> UserData {
		let userData = UserInfoData(nickName: displayName,
									birthday: dateOfBirth,
									gender: GenderType(type: gender),
									avatar: avatar,
									first_name: firstName,
									last_name: lastName)
		
		let healthData = HealthData(created_at: memberSince,
									height: height,
									weight: weight,
									health_source: .fitbit)
		return UserData(userInfo: userData, health: healthData)
	}
}
