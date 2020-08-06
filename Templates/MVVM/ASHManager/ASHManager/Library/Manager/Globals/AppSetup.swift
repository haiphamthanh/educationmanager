//
//  AppSetup.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

enum AppEnviroment {
	case development
	case staging
	case production
}

protocol AppSetupProtocol {
	var appType: AppEnviroment { get }
}

class AppSetup: AppSetupProtocol {
	lazy var isTesting = false
	lazy var isDeveloping = false
	
	let appType: AppEnviroment
	
	class var sharedState: AppSetup {
		struct Static {
			static let instance = AppSetup()
		}
		
		return Static.instance
	}
	
	init() {
		appType = environmentDetected()
		isDeveloping = appType == .development
		if let _ = NSClassFromString("XCTest") {
			isTesting = true
		}
	}
}
