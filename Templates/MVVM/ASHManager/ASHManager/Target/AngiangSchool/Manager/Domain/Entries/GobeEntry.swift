//
//  GobeEntry.swift
//  ASHManager
//
//  Created by KhoaLA on 4/11/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

struct GobeEntry {
	let response_code: Int
	let timestamp: Int
	let request: String
	let public_key: String
	let access_id: String
	let registerDate: String
	let userUUID: String
	let user_info: GobeUserInfo
//	let DeviceUUID: String
//	let integrations: [String]
}

struct GobeUserInfo {
	let firstname: String
	let lastname: String
//	let country: String
//	let CountryISOCode: String
//	let region: String
//	let AdministrativeArea: String
//	let city: String
//	let postalcode: String
//	let street_address_1: String
//	let street_address_2: String
//	let modules: GobeUserInfoModules
//	let preferences: GobeUserInfoPreferences
	let sex: Int
	let weight: Double
	let height: Int
	let b_day: Int
	let b_month: Int
	let b_year: Int
	let normal_Ps: Int
	let normal_Pd: Int
//	let armlength: Int
//	let health_level: Int
//	let step_length: Int
//	let hr_while_standing: Int
//	let diet_type: Int
//	let user_weight_src_id: Int
	let avatar_url: String
//	let account: String
//	let wristband_paired: Bool
//	let hash: String
//	let access_token_expired_at: String
}

struct GobeUserInfoPreferences {
	let distance_unit: String
	let sleep_duration: Int
	let water_unit: String
	let glass_volume: Int
	let vibro_signal: Int
	let rest_offset: Int
	let rest_duration: Int
}

struct GobeUserInfoModules {
	let alarms: String?
	let sleep: String?
	let water: String?
}

