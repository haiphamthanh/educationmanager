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
		id = try map.value("id")
		username = try map.value("username")
		role_id = try map.value("role_id")
		password = (try? map.value("value")) ?? ""
		email = try map.value("email")
		birthday = (try? map.value("birthday")) ?? ""
		gender = (try? map.value("gender")) ?? -1
		avatar = (try? map.value("avatar")) ?? ""
		first_name = (try? map.value("first_name")) ?? ""
		last_name = (try? map.value("last_name")) ?? ""
		latitude = (try? map.value("latitude")) ?? "1"
		longitude = (try? map.value("longitude")) ?? "1"
		avatarData = (try? map.value("avatarData"))
		health_flag = try map.value("health_flag")
		profile_flag = try map.value("profile_flag")
		nickName = (try? map.value("nick_name")) ?? ""
		announcement_flag = try map.value("announcement_flag")
		advices_flag = try map.value("advices_flag")
		contest_notifications_flag = try map.value("contest_notifications_flag")
		email_marketing_setting = try map.value("email_marketing_setting")
	}
	
	func toData() -> UserInfoData {
		return UserInfoData(id: id, role_id: role_id, nickName: nickName, username: username, password: password, email: email, birthday: birthday, gender: GenderType(rawValue: gender)!, avatar: avatar, avatarData: avatarData, first_name: first_name, last_name: last_name, latitude: latitude, longitude: longitude, health_flag: health_flag, profile_flag: profile_flag, announcement_flag: announcement_flag, advices_flag: advices_flag, contest_notifications_flag: contest_notifications_flag, email_marketing_setting: email_marketing_setting)
	}
}
