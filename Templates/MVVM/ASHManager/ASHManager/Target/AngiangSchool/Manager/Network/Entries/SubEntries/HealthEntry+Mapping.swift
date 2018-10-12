//
//  HealthEntry.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension HealthEntry: ImmutableMappable {
	
	// JSON -> Object
	init(map: Map) throws {
		code = (try? map.value("code")) ?? ""
		code_life_time = (try? map.value("code_life_time")) ?? ""
		created_at = (try? map.value("created_at")) ?? ""
		updated_at = (try? map.value("updated_at")) ?? ""
		
		let tempHeight: String = (try? map.value("height")) ?? "-1.0"
		let tempWeight: String = (try? map.value("weight")) ?? "-1.0"
		
		height = Double(tempHeight)!
		height_type = (try? map.value("height_type")) ?? -1
		weight = Double(tempWeight)!
		weight_type = (try? map.value("weight_type")) ?? -1
		blood_pressure_upper = (try? map.value("blood_pressure_upper")) ?? -1
		blood_pressure_under =  (try? map.value("blood_pressure_under")) ?? -1
		blood_type = (try? map.value("blood_type")) ?? BloodType.a.rawValue
		surgery_status = (try? map.value("surgery_status")) ?? -1
		feel_condition = (try? map.value("feel_condition")) ?? -1
		smoking_level = (try? map.value("smoking_level")) ?? -1
		smoking_frequency = (try? map.value("smoking_each_time")) ?? -1
		alcohol_level = (try? map.value("alcohol_level")) ?? -1
		drink_frequency = (try? map.value("drink_each_time")) ?? -1
		gobe_username = (try? map.value("gobe_username")) ?? ""
		gobe_password = (try? map.value("gobe_password")) ?? ""
		fitbit_access_token = (try? map.value("fitbit_access_token")) ?? ""
		fitbit_refresh_token = (try? map.value("fitbit_refresh_token")) ?? ""
		fitbit_expires_in = (try? map.value("fitbit_expires_in")) ?? -1
		health_source = (try? map.value("health_source")) ?? -1
	}
	
	func toData() -> HealthData {
		
		return HealthData(code: code,
						  code_life_time: code_life_time,
						  created_at: created_at,
						  updated_at: updated_at,
						  height: height,
						  height_type: HeightType(rawValue: height_type)!,
						  weight: weight,
						  weight_type: WeightType(rawValue: weight_type)!,
						  blood_pressure_upper: blood_pressure_upper,
						  blood_pressure_under: blood_pressure_under,
						  blood_type: BloodType(rawValue: blood_type)!,
						  surgery_status: Surgery(rawValue: surgery_status)!,
						  feel_condition: FeelCondition(rawValue: feel_condition)!,
						  smoking_level: SmokingLevel(rawValue: smoking_level)!,
						  smoking_frequency: SmokingFrequency(rawValue: smoking_frequency)!,
						  alcohol_level: AlcoholLevel(rawValue: alcohol_level)!,
						  drink_frequency: AlcoholFrequency(rawValue: drink_frequency)!,
						  gobe_username: gobe_username ,
						  gobe_password: gobe_password,
						  fitbit_access_token: fitbit_access_token,
						  fitbit_refresh_token: fitbit_refresh_token,
						  fitbit_expires_in: fitbit_expires_in,
						  health_source: HealthSource(rawValue: health_source)!)
	}
	
	// TODO: Hack for blood and need to remove later
	private static func changeToInt(blood: String) -> Int {
		return BloodType.init(blood).rawValue
	}
}
