//
//  UserInfoData.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

enum GenderType: Int {
	case other = -1
	case male = 1
	case female
	
	init(type: String) {
		switch type {
		case "FEMALE":
			self = .female
		case "MALE":
			self = .male
		default:
			self = .other
		}
	}
	
	func desc() -> (name: String, selectedIcon: String, unSelectedIcon: String)? {
		switch self {
		case .female:
			return (name: LocalizedString.femaleTitle(), selectedIcon: "ic_female_selected", unSelectedIcon: "ic_female")
		case .male:
			return (name: LocalizedString.maleTitle(), selectedIcon: "ic_male_selected", unSelectedIcon: "ic_male")
		default:
			return nil
		}
	}
}

struct UserInfoData {
	var id: Int
	var role_id: Int
	var nickName: String?
	var username: String
	var password: String
	var email: String
	var birthday: String
	var gender: GenderType
	var avatar: String
	var avatarData: Data?
	var first_name: String
	var last_name: String
	var latitude: String
	var longitude: String
	var health_flag: Bool
	var profile_flag: Bool
	var announcement_flag: Bool
	var advices_flag: Bool
	var contest_notifications_flag: Bool
	var email_marketing_setting: Bool
	
	func address() -> String? {
		// TODO: Define later
		return nil
	}
}

extension UserInfoData {
	init(id: Int = -1,
		 rold_id: Int = 1,
		 nickName: String? = "",
		 username: String = "",
		 password: String = "",
		 email: String = "",
		 birthday: String = "",
		 gender: GenderType = .male,
		 avatar: String = "",
		 avatarData: Data? = nil,
		 first_name: String = "",
		 last_name: String = "",
		 latitude: String = "1",
		 longitude: String = "1",
		 profile_flag: Bool = true,
		 health_flag: Bool = true,
		 announcement_flag: Bool = true,
		 advices_flag: Bool = true,
		 contest_notifications_flag: Bool = true,
		 email_marketing_setting: Bool = true) {
		
		self.id = id
		self.role_id = rold_id
		self.nickName = nickName
		self.username = username
		self.password = password
		self.email = email
		self.birthday = birthday
		self.gender = gender
		self.avatar = avatar
		self.avatarData = avatarData
		self.first_name = first_name
		self.last_name = last_name
		self.latitude = latitude
		self.longitude = longitude
		self.health_flag = health_flag
		self.profile_flag = profile_flag
		self.announcement_flag = announcement_flag
		self.advices_flag = advices_flag
		self.contest_notifications_flag = contest_notifications_flag
		self.email_marketing_setting = email_marketing_setting
	}
}

extension UserInfoData: Equatable {
	static func == (lhs: UserInfoData, rhs: UserInfoData) -> Bool {
		return lhs.id == rhs.id &&
			lhs.username == rhs.username &&
			lhs.role_id == rhs.role_id &&
			lhs.password == rhs.password &&
			lhs.email == rhs.email &&
			lhs.birthday == rhs.birthday &&
			lhs.gender == rhs.gender &&
			lhs.avatar == rhs.avatar &&
			lhs.first_name == rhs.first_name &&
			lhs.last_name == rhs.last_name &&
			lhs.nickName == rhs.nickName
	}
}
