//
//  Config.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import StoreKit
import SafariServices

class Config: BaseConfig {
	class func schemeOpenUrl() -> String? { return "genki" }
	static let GOOGLE_MAP_API_KEY = "AIzaSyDii6nQwCwtUO8W2UjdvsJyITCkqWvXQxg"
	static let GOOGLE_MAP_PLACES_API_KEY = "AIzaSyAEKYrdAG_qthBDvcPm9_A0pBaYB1Ng_mo"
	static let fitbitClientID = "22CX34"
	static let fitbitClientSecret = "6ef5992147abd17aa601f8d3b72f191d"
	static let fitbitRedirectURI = "genki://"
	static let fitbitExpiresIn = "31536000"
	static let fitbitDefaultScope = "sleep+settings+nutrition+activity+social+heartrate+profile+weight+location"
	static let TWITTER_API_KEY = "0T7gqmJSkXUwx8beqbXCIp518"
	static let TWITTER_API_SECRET = "VQShts1ke0dFIuDoyGE2lNnB8Q5Ysh1VVCo5UT0uXgDrDgC1Fv"
	/** expiresIn Details
	// 86400 for 1 day
	// 604800 for 1 week
	// 2592000 for 30 days
	// 31536000 for 1 year
	*/
	static func appToken() -> String? {
		return Defaults[.token]
	}
	
	static func appRefreshToken() -> String? {
		return Defaults[.refreshToken]
	}
	
	static func keep(token: String, roleId: Int) {
		Defaults[.token] = token
		Defaults[.role] = roleId
	}
	
	static func keep(refreshToken: String?) {
		Defaults[.refreshToken] = refreshToken
	}
	
	static func revokeToken(){
		Defaults.remove(.token)
		Defaults.remove(.role)
		Defaults.remove(.refreshToken)
	}
	
	static func requestFitbitCode(delegate: Any) -> SFSafariViewController {
		let url: URL = URL(string: String(format:"%@?response_type=code&client_id=%@&redirect_uri=%@&scope=%@&expires_in=%@",
										  "https://www.fitbit.com/oauth2/authorize",
										  Config.fitbitClientID,
										  Config.fitbitRedirectURI,
										  Config.fitbitDefaultScope,
										  Config.fitbitExpiresIn))!
		let authorizationViewController = SFSafariViewController(url: url)
		authorizationViewController.delegate = delegate as? SFSafariViewControllerDelegate
		return authorizationViewController
	}
}

extension DefaultsKeys {
	static let token = DefaultsKey<String?>("token")
	static let refreshToken = DefaultsKey<String?>("refresh_token")
	static let role = DefaultsKey<Int?>("role")
}
