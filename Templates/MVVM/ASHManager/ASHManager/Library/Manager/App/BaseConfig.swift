//
//  BaseConfig.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

class BaseConfig : NSObject {
	class func maxUploadFileSize() -> Int { return 10 }
	class func maxUploadVideoSize() -> Int { return 25 }
	class func maxVideoCaptureDurationSec() -> TimeInterval { return 5 * 60 }
	class func maxAudioRecordDurationSec() -> Double { return 60.0 }
	class func httpTimeOutSec() -> TimeInterval { return 60.0 }
}

extension URL {
	var fileSize: UInt64 {
		if let info: NSDictionary = try? FileManager.default.attributesOfItem(atPath: self.path) as NSDictionary {
			return info.fileSize()
		}
		return 0
	}
}
