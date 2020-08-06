//
//  AppInfo.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import SwiftyUserDefaults

class AppInfo {
	static let APP_NAME = "EduAnGiang"
	static let APP_VERSION = "0.01"
	static let APP_KEY = ""
	static let APP_SECRECT_KEY = ""
}

struct XAccessToken {
	/** expires In Details
	// 86400 for 1 day
	// 604800 for 1 week
	// 2592000 for 30 days
	// 31536000 for 1 year
	*/
	
	// MARK: - Properties
	var token: String? {
		get {
			let key = Defaults[.token]
			return key
		}
		set(newToken) {
			Defaults[.token] = newToken
		}
	}
	
	var refreshToken: String? {
		get {
			let key = Defaults[.refreshToken]
			return key
		}
		set(newRefreshToken) {
			Defaults[.refreshToken] = newRefreshToken
		}
	}
	
	var expiry: Double? {
		get {
			return Defaults[.expiry]
		}
		set(newExpiry) {
			Defaults[.expiry] = newExpiry
		}
	}
	
	var expired: Bool {
		if let expiry = expiry {
			let date = Date(timeIntervalSince1970: expiry)
			return date.isInPast
		}
		
		return true
	}
	
	var isValid: Bool {
		if let token = token {
			return !token.isEmpty && !expired
		}
		
		return false
	}
}
