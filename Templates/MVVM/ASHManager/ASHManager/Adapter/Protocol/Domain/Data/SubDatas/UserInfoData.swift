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
	case male = 0
	case female
	
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
	var uid: String
	var role_id: Int
	var nickName: String?
	var username: String
	var email: String
	var birthday: String
	var gender: GenderType
	var avatar: String?
	var picture: Data?
	var first_name: String
	var last_name: String
	var latitude: Double
	var longitude: Double
	var address: String
	var token: String
	var refreshToken: String
	var expiry: Double
	var created_at: Double
	var updated_at: Double
}

extension UserInfoData: Equatable {
	static func == (lhs: UserInfoData, rhs: UserInfoData) -> Bool {
		return lhs.uid == rhs.uid
	}
}

extension UserInfoData: DomainConvertibleType {
	func asDomain() -> UserInfoEntry {
		return UserInfoEntry(uid: uid,
							 role_id: role_id,
							 nickName: nickName,
							 username: username,
							 email: email,
							 birthday: birthday,
							 gender: gender.rawValue,
							 avatar: avatar,
							 picture: picture,
							 first_name: first_name,
							 last_name: last_name,
							 latitude: latitude,
							 longitude: longitude,
							 address: address,
							 token: token,
							 refreshToken: refreshToken,
							 expiry: expiry,
							 created_at: created_at,
							 updated_at: updated_at)
	}
}
