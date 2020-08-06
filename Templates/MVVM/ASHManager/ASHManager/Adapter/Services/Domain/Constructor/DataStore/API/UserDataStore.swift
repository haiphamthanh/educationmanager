//
//  UserDataStore.swift
//  ASEducation
//
//  Created by 7i3u7u on 11/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

final class UserDataStore {
	// GET
	func userInfo(input: InNWUserInfo) -> OutNWUserData {
		let task = ReadUserTask()
		let result = task
			.execute()
			.map(transformToData)
		
		return OutNWUserData(0, result)
	}
	
	// PUT
	func update(input: InNWUserUpdate) -> OutNWUserData {
		let userEntry = input.user.asDomain()
		
		let task = UpdateUserTask.init(user: userEntry)
		let result = task
			.execute()
			.map(transformToData)
		
		return OutNWUserData(0, result)
	}
	
	private func transformToData(_ users: [UserEntry]) -> UserData {
		guard let user = users.first else {
			fatalError("Can not find user")
		}
		
		return user.asData()
	}
}
