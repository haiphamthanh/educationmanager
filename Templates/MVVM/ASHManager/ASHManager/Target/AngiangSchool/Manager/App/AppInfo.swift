//
//  AppInfo.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

class AppInfo {
	static let APP_NAME = "Genki"
	static let APP_VERSION = "v0.01"
	static let APP_TYPE = 2
}

class ServiceInfo {
	static let GOOGLE_CLIENT_ID = "295507837305-mnt4b6tmce2okhjln7rirc8chrlm7s45.apps.googleusercontent.com"
	static let FACEBOOK_CLIENT_ID = ""
}

class ServerInfo {
	
#if PRODUCTION
	static let DATA_SERVER_URL = "https://de-genki.genkimiru.jp"
	static let ECOMER_SERVER_URL = "https://de-genkiec.genkimiru.jp"
	static let ECOMER_TOKEN_PARAMS = "/authentication/account/fastlogin?token="
	static let DATA_SERVER_URL_EXTENSION = "https://de-genkius.genkimiru.jp"
	static let DATA_SERVER_API_VERSION = "/api/v1"
	static let DATA_SERVER_ROOT_URL = DATA_SERVER_URL + DATA_SERVER_API_VERSION
	
	static let HEADER_SERVER_KEY: String? = "Authorization"
	static let HEADER_SERVER_VALUE: String? = "Basic Z2Vua2l1c2VyOmdlbmtpcGFzc3dvcmQ="
	static let HEADER_TIMEZONE_KEY: String? = "timezone"
	static let HEADER_TIMEZONE_VALUE: String? = Calendar.current.timeZone.identifier.replacingOccurrences(of: " ", with: "_")
	
	static let HEADER_SERVER_PARAMS: [String: String]? = [HEADER_SERVER_KEY!: HEADER_SERVER_VALUE!, HEADER_TIMEZONE_KEY!: HEADER_TIMEZONE_VALUE!]
	
	static let PUSH_SERVER_URL = ""
	static let SUPPORT_URL = ""
	static let DESCRIPTION = "production"
#elseif STAGING
	static let DATA_SERVER_URL = "https://st-genki.genkimiru.jp"
	static let ECOMER_SERVER_URL = "https://st-genkiec.genkimiru.jp"
	static let ECOMER_TOKEN_PARAMS = "/authentication/account/fastlogin?token="
	static let DATA_SERVER_URL_EXTENSION = "https://de-genkius.genkimiru.jp"
	static let DATA_SERVER_API_VERSION = "/api/v1"
	static let DATA_SERVER_ROOT_URL = DATA_SERVER_URL + DATA_SERVER_API_VERSION
	
	static let HEADER_SERVER_KEY: String? = "Authorization"
	static let HEADER_SERVER_VALUE: String? = "Basic Z2Vua2l1c2VyOmdlbmtpcGFzc3dvcmQ="
	static let HEADER_TIMEZONE_KEY: String? = "timezone"
	static let HEADER_TIMEZONE_VALUE: String? = Calendar.current.timeZone.identifier.replacingOccurrences(of: " ", with: "_")
	
	static let HEADER_SERVER_PARAMS: [String: String]? = [HEADER_SERVER_KEY!: HEADER_SERVER_VALUE!, HEADER_TIMEZONE_KEY!: HEADER_TIMEZONE_VALUE!]
	
	static let PUSH_SERVER_URL = ""
	static let SUPPORT_URL = ""
	static let DESCRIPTION = "staging"
#else
	static let DATA_SERVER_URL = "https://de-genki.genkimiru.jp"
	static let ECOMER_SERVER_URL = "https://de-genkiec.genkimiru.jp"
	static let ECOMER_TOKEN_PARAMS = "/authentication/account/fastlogin?token="
	static let DATA_SERVER_URL_EXTENSION = "https://de-genkius.genkimiru.jp"
	static let DATA_SERVER_API_VERSION = "/api/v1"
	static let DATA_SERVER_ROOT_URL = DATA_SERVER_URL + DATA_SERVER_API_VERSION
	
	static let HEADER_SERVER_KEY: String? = "Authorization"
	static let HEADER_SERVER_VALUE: String? = "Basic Z2Vua2l1c2VyOmdlbmtpcGFzc3dvcmQ="
	static let HEADER_TIMEZONE_KEY: String? = "timezone"
	static let HEADER_TIMEZONE_VALUE: String? = Calendar.current.timeZone.identifier.replacingOccurrences(of: " ", with: "_")
	
	static let HEADER_SERVER_PARAMS: [String: String]? = [HEADER_SERVER_KEY!: HEADER_SERVER_VALUE!, HEADER_TIMEZONE_KEY!: HEADER_TIMEZONE_VALUE!]
	
	static let PUSH_SERVER_URL = ""
	static let SUPPORT_URL = ""
	static let DESCRIPTION = "production"
#endif
	
	class func webSocketURL() -> String {
		return "\(PUSH_SERVER_URL)/v2/websocket"
	}
}
