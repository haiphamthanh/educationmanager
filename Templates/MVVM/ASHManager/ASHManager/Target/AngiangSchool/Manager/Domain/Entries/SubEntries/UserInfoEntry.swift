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
	let id: Int
	let username: String
	let role_id: Int
	let password: String
	let email: String
	let birthday: String
	let gender: Int
	let avatar: String
	var avatarData: Data?
	let first_name: String
	let last_name: String
	let latitude: String
	let longitude: String
	let health_flag: Bool
	let profile_flag: Bool
	let nickName: String?
	let announcement_flag: Bool
	let advices_flag: Bool
	let contest_notifications_flag: Bool
	let email_marketing_setting: Bool
}
