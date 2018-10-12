//
//  HealthEntry.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

// MARK: - ================================= Health =================================
struct HealthEntry {
	let code: String
	let code_life_time: String
	let created_at: String
	let updated_at: String
	let height: Double
	let height_type: Int
	let weight: Double
	let weight_type: Int
	let blood_pressure_upper: Int
	let blood_pressure_under: Int
	let blood_type: Int
	let surgery_status: Int
	let feel_condition: Int
	let smoking_level: Int
	let smoking_frequency: Int
	let alcohol_level: Int
	let drink_frequency: Int
	let gobe_username: String
	let gobe_password: String
	let fitbit_access_token: String
	let fitbit_refresh_token: String
	let fitbit_expires_in: Int
	let health_source: Int
}
