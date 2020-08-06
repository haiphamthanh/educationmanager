//
//  UserEntry.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/04/02.
//  Copyright © 2018 Asahi. All rights reserved.
//

struct UserEntry {
	let uid: String
	let userInfo: UserInfoEntry
	let health: HealthEntry
}

extension UserEntry: DataPresentation {
	typealias DataType = UserData
	
	func asData() -> DataType {
		return UserData.init(uid: uid,
							 userInfo: userInfo.asData(),
							 health: health.asData())
	}
}
