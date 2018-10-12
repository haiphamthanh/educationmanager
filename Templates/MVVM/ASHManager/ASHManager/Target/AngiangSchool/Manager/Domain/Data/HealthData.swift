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
	
	init(_ type: String) {
		switch type {
		case "A":
			self = .a
		case "B":
			self = .b
		case "AB":
			self = .ab
		case "O":
			self = .o
		default:
			self = .other
		}
	}
	
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

enum AlcoholFrequency: Int {
	case other = -1
	case everyday = 1
	case fiveToSixTimesPerWeek
	case threeToFourTimesPerWeek
	case oneToTwoTimesPerWeek
	case oneToThreePerMonth
	case stopForMoreThanOneYear
	case canNotDrink
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .everyday:
			return LocalizedString.localizedString(input: "CheckBox1")
		case .fiveToSixTimesPerWeek:
			return LocalizedString.localizedString(input: "CheckBox2")
		case .threeToFourTimesPerWeek:
			return LocalizedString.localizedString(input: "CheckBox3")
		case .oneToTwoTimesPerWeek:
			return LocalizedString.localizedString(input: "CheckBox4")
		case .oneToThreePerMonth:
			return LocalizedString.localizedString(input: "CheckBox5")
		case .stopForMoreThanOneYear:
			return LocalizedString.localizedString(input: "CheckBox6")
		case .canNotDrink:
			return LocalizedString.localizedString(input: "CheckBox7")
		}
	}
}

enum Surgery: Int {
	case other = -1
	case no = 0
	case yes
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .no:
			return LocalizedString.localizedString(input: "No")
		case .yes:
			return LocalizedString.localizedString(input: "Yes")
		}
	}
	
	func answerDesc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .no:
			return LocalizedString.localizedString(input: "Surgery_Text_Answer_No")
		case .yes:
			return LocalizedString.localizedString(input: "Surgery_Text_Answer_Yes")
		}
	}
}

enum FeelCondition: Int {
	case other = -1
	case verygood = 1
	case good
	case bad
	case verybad
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .verygood:
			return LocalizedString.localizedString(input: "Health_Checkbox1")
		case .good:
			return LocalizedString.localizedString(input: "Health_Checkbox2")
		case .bad:
			return LocalizedString.localizedString(input: "Health_Checkbox3")
		case .verybad:
			return LocalizedString.localizedString(input: "Health_Checkbox4")
		}
	}
	
	func answerDesc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .verygood:
			return LocalizedString.localizedString(input: "Health_VeryGood")
		case .good:
			return LocalizedString.localizedString(input: "Health_Good")
		case .bad:
			return LocalizedString.localizedString(input: "Health_Notbad")
		case .verybad:
			return LocalizedString.localizedString(input: "Health_Bad")
		}
	}
}

enum AlcoholLevel: Int {
	case other = -1
	case lessthanOne = 1
	case oneToTwo
	case twoToThree
	case threeToFour
	case fourToFive
	case moreThanFive
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .lessthanOne:
			return LocalizedString.drinkPopupCheckbox1Title()
		case .oneToTwo:
			return LocalizedString.drinkPopupCheckbox2Title()
		case .twoToThree:
			return LocalizedString.drinkPopupCheckbox3Title()
		case .threeToFour:
			return LocalizedString.drinkPopupCheckbox4Title()
		case .fourToFive:
			return LocalizedString.drinkPopupCheckbox5Title()
		case .moreThanFive:
			return LocalizedString.drinkPopupCheckbox6Title()
		}
	}
	
	init(name: String) {
		switch name {
		case AlcoholLevel.lessthanOne.desc():
			self = .lessthanOne
		case AlcoholLevel.oneToTwo.desc():
			self = .oneToTwo
		case AlcoholLevel.twoToThree.desc():
			self = .twoToThree
		case AlcoholLevel.threeToFour.desc():
			self = .threeToFour
		case AlcoholLevel.fourToFive.desc():
			self = .fourToFive
		case AlcoholLevel.moreThanFive.desc():
			self = .moreThanFive
		default:
			self = .lessthanOne
		}
	}
}

enum SmokingFrequency: Int {
	case other = -1
	case noway = 1
	case whenDrinking
	case everyday
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .noway:
			return LocalizedString.smokeCheckbox1Title()
		case .whenDrinking:
			return LocalizedString.smokeCheckbox2Title()
		case .everyday:
			return LocalizedString.smokeCheckbox3Title()
		}
	}
}

enum SmokingLevel: Int {
	case other = -1
	case lessThanTen = 1
	case lessThanTwenty
	case moreThanTwenty
	
	func desc() -> String {
		switch self {
		case .other:
			return LocalizedString.unknown()
		case .lessThanTen:
			return LocalizedString.smokePopupCheckbox1Title()
		case .lessThanTwenty:
			return LocalizedString.smokePopupCheckbox2Title()
		case .moreThanTwenty:
			return LocalizedString.smokePopupCheckbox3Title()
		}
	}
	
	init(name: String) {
		switch name {
		case SmokingLevel.lessThanTen.desc():
			self = .lessThanTen
		case SmokingLevel.lessThanTwenty.desc():
			self = .lessThanTwenty
		case SmokingLevel.moreThanTwenty.desc():
			self = .moreThanTwenty
		default:
			self = .other
		}
	}
}

// Define user source device
enum HealthSource: Int {
	case noneApp = -1
	case gobe = 1
	case fitbit
	case apple
	case smartphone
	case googleFit
	
	func desc() -> (image: String?, title: String?) {
		switch self {
		case .gobe:
			return (image: "ic_gobe", title: nil)
		case .fitbit:
			return (image: "ic_fitbit", title: nil)
		case .apple:
			return (image: nil, title: LocalizedString.otherWearableButtonTitle())
		case .smartphone:
			return (image: nil, title: LocalizedString.smartPhoneTitle())
		default:
			return (image: nil, title: nil)
		}
	}
}

struct HealthData {
	var code: String
	var code_life_time: String
	var created_at: String
	var updated_at: String
	var height: Double
	var height_type: HeightType
	var weight: Double
	var weight_type: WeightType
	var blood_pressure_upper: Int
	var blood_pressure_under: Int
	var blood_type: BloodType
	var surgery_status: Surgery
	var feel_condition: FeelCondition
	var smoking_level: SmokingLevel
	var smoking_frequency: SmokingFrequency
	var alcohol_level: AlcoholLevel
	var drink_frequency: AlcoholFrequency
	var gobe_username: String?
	var gobe_password: String?
	var fitbit_access_token: String?
	var fitbit_refresh_token: String?
	var fitbit_expires_in: Int?
	var health_source: HealthSource
	
	// Hard code to normal value
	init(code: String = "",
		 code_life_time: String = "",
		 created_at: String = "",
		 updated_at: String = "",
		 height: Double = 180,
		 height_type: HeightType = HeightType.cm,
		 weight: Double = 65,
		 weight_type: WeightType = WeightType.kg,
		 blood_pressure_upper: Int = 120,
		 blood_pressure_under: Int = 120,
		 blood_type: BloodType = .other,
		 surgery_status: Surgery = .other,
		 feel_condition: FeelCondition = .other,
		 smoking_level: SmokingLevel = .other,
		 smoking_frequency: SmokingFrequency = .other,
		 alcohol_level: AlcoholLevel = .other,
		 drink_frequency: AlcoholFrequency = .other,
		 gobe_username: String = "",
		 gobe_password: String = "",
		 fitbit_access_token: String? = "",
		 fitbit_refresh_token: String? = "",
		 fitbit_expires_in: Int = 0,
		 health_source: HealthSource = .noneApp) {
		
		self.code = code
		self.code_life_time = code_life_time
		self.created_at = created_at
		self.updated_at = updated_at
		self.height = height
		self.height_type = height_type
		self.weight = weight
		self.weight_type = weight_type
		self.blood_pressure_upper = blood_pressure_upper
		self.blood_pressure_under = blood_pressure_under
		self.blood_type = blood_type
		self.surgery_status = surgery_status
		self.feel_condition = feel_condition
		self.smoking_level = smoking_level
		self.smoking_frequency = smoking_frequency
		self.alcohol_level = alcohol_level
		self.drink_frequency = drink_frequency
		self.gobe_username = gobe_username
		self.gobe_password = gobe_password
		self.fitbit_access_token = fitbit_access_token
		self.fitbit_refresh_token = fitbit_refresh_token
		self.fitbit_expires_in = fitbit_expires_in
		self.health_source = health_source
	}
	
	func sourcDesc() -> (name: String, icon: String) {
		var name = "Other"
		var icon = "ic_phone_blue"
		switch health_source {
		case .gobe:
			name = "GoBe"
			icon = "ic_gobe_blue"
		case .fitbit:
			name = "Fitbit"
			icon = "ic_fitbit_blue"
		case .apple:
			name = LocalizedString.localizedString(input: "Title_Other_Wearable_Button")
			icon = "ic_other_devices_blue"
		case .smartphone:
			name = LocalizedString.localizedString(input: "Title_Smart_Phone_Button")
			icon = "ic_phone_blue"
		default: break
		}
		
		return (name: name, icon: icon)
	}
	
	func bloodPressure() -> String {
		return "\(blood_pressure_upper) / \(blood_pressure_under)"
	}
}

struct HealthListDateData {
	let list_input_dates: [String]
}

struct HealthRequestData {
	let data: HealthCheckData
}

struct HealthCheckData {
	var fat: FatData
	var liver: LiverData
	var blood: BloodData
	var urine: UrineData
}

struct FatData {
	let fat_neutral: String?
	let cholesterol_hdl: String?
	let cholesterol_ldl: String?
}

struct LiverData {
	let got: String?
	let gpt: String?
	let vgt: String?
}

struct BloodData {
	let sugar: String?
}

struct UrineData {
	let protein: String?
}

extension HealthData: Equatable {
	static func == (lhs: HealthData, rhs: HealthData) -> Bool {
		return lhs.height == rhs.height
			&& lhs.height_type == rhs.height_type
			&& lhs.weight == rhs.weight
			&& lhs.weight_type == rhs.weight_type
	}
}
