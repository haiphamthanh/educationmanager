//
//  AppDelegate.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

@UIApplicationMain
class AppDelegate: BaseAppDelegate {
	
	// MARK: - ================================= Properties =================================
	//+++ Singleton ============
	override class func shared<T: AppDelegate>() -> T {
		return super.shared()
	}
	
	// MARK: - ================================= Overrided =================================
	override func register(container: Container, window: UIWindow) {
		super.register(container: container, window: window)
		
		container.register(MainServiceProtocol.self) { _ in MainService() }
		container.register(RegisterAppServiceProtocol.self) { _ in RegisterApp(container: container, window: window) }
	}
}
