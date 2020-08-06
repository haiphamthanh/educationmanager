//
//  User.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

struct UserData {
	var uid: String
	var userInfo: UserInfoData
	var health: HealthData
}

extension UserData: Equatable {
	static func == (lhs: UserData, rhs: UserData) -> Bool {
		return lhs.uid == rhs.uid
	}
}

extension UserData: DomainConvertibleType {
	func asDomain() -> UserEntry {
		return UserEntry(uid: uid,
						 userInfo: userInfo.asDomain(),
						 health: health.asDomain())
	}
}
