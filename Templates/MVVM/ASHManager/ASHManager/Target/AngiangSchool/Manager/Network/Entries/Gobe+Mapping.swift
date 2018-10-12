//
//  Gobe+Mapping.swift
//  ASHManager
//
//  Created by KhoaLA on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper
extension Int {
	func toString() -> String {
		if self == -1 || self < 0 {
			return "--"
		}
		let formatter = NumberFormatter()
		formatter.groupingSeparator = ","
		formatter.numberStyle = .decimal
		return formatter.string(from: NSNumber(value: self)) ?? ""
	}
}

extension GobeEntry: ImmutableMappable {
	init(map: Map) throws {
		response_code = try map.value("response_code")
		timestamp = try map.value("timestamp")
		request = try map.value("request")
		public_key = try map.value("public_key")
		access_id = try map.value("access_id")
		registerDate = try map.value("registerDate")
		userUUID = try map.value("userUUID")
		user_info = try map.value("user_info")
	}
	
	func toData() -> UserData {
		var b_day: String = user_info.b_day.toString()
		
		if user_info.b_day < 10 {
			b_day = user_info.b_day.toString().replacingOccurrences(of: user_info.b_day.toString(), with: "\(0)\(user_info.b_day.toString())")
		}
		
		let userData = UserInfoData(birthday: "\(user_info.b_year)-\(user_info.b_month)-\(b_day)",
									gender: GenderType(rawValue: user_info.sex)!,
									avatar: user_info.avatar_url,
									first_name: user_info.firstname,
									last_name: user_info.lastname)
		
		let healthData = HealthData(created_at: registerDate,
									updated_at: timestamp.toString(),
									height: Double(user_info.height),
									height_type: HeightType.cm,
									weight: Double(user_info.weight),
									weight_type: WeightType.kg,
									blood_pressure_upper: user_info.normal_Ps,
									blood_pressure_under: user_info.normal_Pd,
									health_source: .gobe)
		
		return UserData(userInfo: userData, health: healthData)
	}
}

extension GobeUserInfo: ImmutableMappable {
	init(map: Map) throws {
		firstname = (try? map.value("firstname")) ?? ""
		lastname = (try? map.value("lastname")) ?? ""
		sex = (try? map.value("sex")) ?? 0
		weight = (try? map.value("weight")) ?? 0
		height = (try map.value("height")) ?? 0
		b_day = (try? map.value("b_day")) ?? 0
		b_month = (try map.value("b_month")) ?? 0
		b_year = (try? map.value("b_year")) ?? 0
		avatar_url = (try? map.value("avatar_url")) ?? ""
		normal_Ps = (try? map.value("normal_Ps")) ?? 0
		normal_Pd = (try? map.value("normal_Pd")) ?? 0
	}
}
