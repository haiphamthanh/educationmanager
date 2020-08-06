//
//  ServiceInfo.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/13/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

protocol ServiceInfo {
	var googleCliendId: String { get }
	var googleAPIKey: String { get }
	
	var twitterAPIKey: String { get }
	var twitterAPISecretKey: String { get }
}

// Usage class
class Service: ServiceInfo {
	class var shared: ServiceInfo {
		struct Static {
			static let instance = Service()
		}
		
		return Static.instance
	}
	
	private var serviceInfo: ServiceInfo
	private init() {
		let env = AppDelegate.shared().globalManager.appSetup.appType
		switch env {
		case .development:
			self.serviceInfo = TestingService()
		case .staging:
			self.serviceInfo = StagingService()
		case .production:
			self.serviceInfo = ProductionService()
		}
	}
	
	var googleCliendId: String {
		return serviceInfo.googleCliendId
	}
	
	var googleAPIKey: String {
		return serviceInfo.googleAPIKey
	}
	
	var twitterAPIKey: String {
		return serviceInfo.twitterAPIKey
	}
	
	var twitterAPISecretKey: String {
		return serviceInfo.twitterAPISecretKey
	}
}

// Should not access directly this groupd (Just use for developing)
private class TestingService: ServiceInfo {
	var googleCliendId: String {
		return "267441227971-f5ps0p8rdhqlqgp65tbce0pckal41gd1.apps.googleusercontent.com"
	}
	
	var googleAPIKey: String {
		return "AIzaSyD0HFYl0DnWJsh7bN6q6QlXNJm6ts1yYng"
	}
	
	var twitterAPIKey: String {
		return "0T7gqmJSkXUwx8beqbXCIp518"
	}
	
	var twitterAPISecretKey: String {
		return "VQShts1ke0dFIuDoyGE2lNnB8Q5Ysh1VVCo5UT0uXgDrDgC1Fv"
	}
}

private class StagingService: ServiceInfo {
	var googleCliendId: String {
		return "295507837305-mnt4b6tmce2okhjln7rirc8chrlm7s45.apps.googleusercontent.com"
	}
	
	var googleAPIKey: String {
		return "AIzaSyD0HFYl0DnWJsh7bN6q6QlXNJm6ts1yYng"
	}
	
	var twitterAPIKey: String {
		return "0T7gqmJSkXUwx8beqbXCIp518"
	}
	
	var twitterAPISecretKey: String {
		return "VQShts1ke0dFIuDoyGE2lNnB8Q5Ysh1VVCo5UT0uXgDrDgC1Fv"
	}
}

private class ProductionService: ServiceInfo {
	var googleCliendId: String {
		return "295507837305-mnt4b6tmce2okhjln7rirc8chrlm7s45.apps.googleusercontent.com"
	}
	
	var googleAPIKey: String {
		return "AIzaSyD0HFYl0DnWJsh7bN6q6QlXNJm6ts1yYng"
	}
	
	var twitterAPIKey: String {
		return "0T7gqmJSkXUwx8beqbXCIp518"
	}
	
	var twitterAPISecretKey: String {
		return "VQShts1ke0dFIuDoyGE2lNnB8Q5Ysh1VVCo5UT0uXgDrDgC1Fv"
	}
}
