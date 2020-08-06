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
	let uid: String
	let height: Double
	let weight: Double
	let blood_type: Int
}

extension HealthEntry: DataPresentation {
	typealias DataType = HealthData
	
	func asData() -> DataType {
		return HealthData(uid: uid,
						  height: height,
						  weight: weight,
						  blood_type: BloodType(rawValue: blood_type)!)
	}
}
