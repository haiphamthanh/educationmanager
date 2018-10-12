//
//  SocialEntry.swift
//  ASHManager
//
//  Created by KhoaLA on 5/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

struct SocialDataEntry {
	let data: SocialInfoEntry
}

struct SocialInfoEntry {
	let googleId: String?
	let facebookId: String?
	let username: String
	let email: String
	let avatar: String?
	let roleId: Int
	let token: String
	let refreshToken: String
}
