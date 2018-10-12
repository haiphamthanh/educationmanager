//
//  FitbitEntry.swift
//  ASHManager
//
//  Created by TienNT12 on 4/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

struct FitbitEntry {
	let refresh_token: String
	let scope: String
	let user_id: String
	let expires_in: Int
	let access_token: String
	let token_type: String
}

struct FitbitUserInfo {
	let age: Int
	let country: String
	let dateOfBirth: String
	let displayName: String
	let displayNameSetting: String
	let encodedId: String
	let firstName: String
	let fullName: String
	let lastName: String
	let gender: String
	let height: Double
	let weight: Double
	let locale: String
	let memberSince: String
	let timezone: String
	let avatar: String
}
