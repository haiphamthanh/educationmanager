//
//  UserInfoEntry.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

// MARK: - ================================= User =================================
struct UserInfoEntry {
	let uid: String
	let role_id: Int
	let nickName: String?
	let username: String
	let email: String
	let birthday: String
	let gender: Int
	let avatar: String?
	let picture: Data?
	let first_name: String
	let last_name: String
	let latitude: Double
	let longitude: Double
	let address: String
	let token: String
	let refreshToken: String
	let expiry: Double
	let created_at: Double
	let updated_at: Double
}

extension UserInfoEntry: DataPresentation {
	typealias DataType = UserInfoData
	
	func asData() -> DataType {
		return UserInfoData(uid: uid,
							role_id: role_id,
							nickName: nickName,
							username: username,
							email: email,
							birthday: birthday,
							gender: GenderType(rawValue: gender)!,
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
