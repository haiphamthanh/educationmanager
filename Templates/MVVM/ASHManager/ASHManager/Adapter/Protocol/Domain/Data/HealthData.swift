//
//  HealthRegister.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

// MARK: - ================================= Enum =================================
enum HeightType: Int {
	case other = -1
	case cm = 1
	case ft_in
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .cm:
			return "cm"
		case .ft_in:
			return "ft/in"
		}
	}
	
	static func translate(height: Double, to: HeightType) -> Double {
		switch to {
		case .other:
			return 0
		case .cm:
			return height * 2.54
		case .ft_in:
			return height * 0.3937
		}
	}
}

enum WeightType: Int {
	case other = -1
	case kg = 1
	case lb
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .kg:
			return "kg"
		case .lb:
			return "lb"
		}
	}
	
	static func translate(weight: Double, to: WeightType) -> Double {
		switch to {
		case .other:
			return 0
		case .kg:
			return weight * 0.453592
		case .lb:
			return weight * 2.20462
		}
	}
}

enum BloodType: Int {
	case other = -1
	case a = 0
	case b
	case ab
	case o
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .a:
			return "A"
		case .b:
			return "B"
		case .ab:
			return "AB"
		case .o:
			return "O"
		}
	}
}

struct HealthData {
	var uid: String
	var height: Double
	var weight: Double
	var blood_type: BloodType
}

extension HealthData: Equatable {
	static func == (lhs: HealthData, rhs: HealthData) -> Bool {
		return lhs.uid == rhs.uid
	}
}

extension HealthData: DomainConvertibleType {
	func asDomain() -> HealthEntry {
		return HealthEntry(uid: uid,
						   height: height,
						   weight: weight,
						   blood_type: blood_type.rawValue)
	}
}
