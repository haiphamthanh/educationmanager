//
//  APIKeys.swift
//  ASEducation
//
//  Created by 7i3u7u on 10/27/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

private let minimumKeyLength = 2

// Mark: - API Keys
struct APIKeys {
	let key: String
	let secret: String
	
	// MARK: Shared Keys
	fileprivate struct SharedKeys {
		static var instance = APIKeys(key: AppInfo.APP_KEY, secret: AppInfo.APP_SECRECT_KEY)
	}
	
	static var sharedKeys: APIKeys {
		get {
			return SharedKeys.instance
		}
		
		set (newSharedKeys) {
			SharedKeys.instance = newSharedKeys
		}
	}
	
	// MARK: Methods
	var stubResponses: Bool {
		return key.count < minimumKeyLength || secret.count < minimumKeyLength
	}
	
	// MARK: Initializers
	init(key: String, secret: String) {
		self.key = key
		self.secret = secret
	}
}
