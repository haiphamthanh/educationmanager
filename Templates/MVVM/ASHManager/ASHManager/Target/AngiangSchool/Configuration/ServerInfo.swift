//
//  ServerInfo.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/13/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

protocol ServerInfo {
	var domain: String { get }
	var version: String { get }
	var root: String { get }
	
	var supportLink: String { get }
	var description: String { get }
}

// Usage class
class Server: ServerInfo {
	class var shared: ServerInfo {
		struct Static {
			static let instance = Server()
		}
		
		return Static.instance
	}
	
	private var serverInfo: ServerInfo
	private init() {
		let env = AppDelegate.shared().globalManager.appSetup.appType
		switch env {
		case .development:
			self.serverInfo = TestingServer()
		case .staging:
			self.serverInfo = StagingServer()
		case .production:
			self.serverInfo = ProductionServer()
		}
	}
	
	var domain: String {
		return serverInfo.domain
	}
	
	var version: String {
		return serverInfo.version
	}
	
	var root: String {
		return serverInfo.root
	}
	
	var supportLink: String {
		return serverInfo.supportLink
	}
	
	var description: String {
		return serverInfo.description
	}
}

// Should not access directly this groupd (Just use for developing)
private class TestingServer: ServerInfo {
	var domain: String {
		return "https://testing-angiangeducation.vn"
	}
	
	var version: String {
		return "/api/v1"
	}
	
	var root: String {
		return domain + version
	}
	
	var supportLink: String {
		return "https://testing-supporting-angiangeducation.vn"
	}
	
	var description: String {
		return "testing"
	}
}

private class StagingServer: ServerInfo {
	var domain: String {
		return "https://st-angiangeducation.vn"
	}
	
	var version: String {
		return "/api/v1"
	}
	
	var root: String {
		return domain + version
	}
	
	var supportLink: String {
		return "https://st-supporting-angiangeducation.vn"
	}
	
	var description: String {
		return "staging"
	}
}

private class ProductionServer: ServerInfo {
	var domain: String {
		return "https://sciences-angiangeducation.vn"
	}
	
	var version: String {
		return "/api/v1"
	}
	
	var root: String {
		return domain + version
	}
	
	var supportLink: String {
		return "https://supporting.angiangeducation.vn"
	}
	
	var description: String {
		return "production"
	}
}
