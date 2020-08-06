//
//  Constants.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/13/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import SwiftyUserDefaults

// Common constants here
class Constant {
}

// Notification keys manager
class ConstantNotiKey: Constant {
	static let tokenExpired = "ConstantNotiKeyTokenExpired"
}

// Oauth key manager
class ConstantOauthKey: Constant {
	static let token = "ConstantOauthKeyToken"
	static let expiry = "ConstantOauthKeyExpiry"
	static let refreshToken = "ConstantOauthKeyRefreshToken"
	
	// If we were given an xAccessToken, add it
	static let accessTokenHeader = "X-Access-Token"
}

// Constant for request variables
class ConstantRequestManager: Constant {
	class func httpTimeOutSec() -> TimeInterval { return 20.0 }
	class func httpRetryTime() -> Int { return 3 }
	class func syncInterval() -> TimeInterval { return 60 }
	
	class func maxTimeDownloadFile() -> TimeInterval { return 60.0 }
	class func maxUploadFileSize() -> Int { return 10 }
	class func maxUploadVideoSize() -> Int { return 25 }
	class func maxVideoCaptureDurationSec() -> TimeInterval { return 5 * 60 }
	class func maxAudioRecordDurationSec() -> Double { return 60.0 }
}

// Add key for SwiftyUserDefaults
extension DefaultsKeys {
	static let token = DefaultsKey<String?>(ConstantOauthKey.token)
	static let refreshToken = DefaultsKey<String?>(ConstantOauthKey.refreshToken)
	static let expiry = DefaultsKey<Double?>(ConstantOauthKey.expiry)
}

// Use for all animation times
struct AnimationDuration {
	static let Normal: TimeInterval = 0.30
	static let Short: TimeInterval = 0.15
}

// Check size of file from URL
extension URL {
	var fileSize: UInt64 {
		if let info: NSDictionary = try? FileManager.default.attributesOfItem(atPath: self.path) as NSDictionary {
			return info.fileSize()
		}
		
		return 0
	}
}
