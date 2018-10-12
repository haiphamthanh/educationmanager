//
//  User.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

struct UserData {
	var userInfo: UserInfoData
	var health: HealthData
}

extension UserData {
	init(userInfo: UserInfoData) {
		self.userInfo = userInfo
		self.health = HealthData()
	}
}

extension UserData: Equatable {
	static func == (lhs: UserData, rhs: UserData) -> Bool {
		return lhs.userInfo == rhs.userInfo && lhs.health == rhs.health
	}
}
