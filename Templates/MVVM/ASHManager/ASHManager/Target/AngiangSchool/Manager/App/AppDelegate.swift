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
	
	//+++ Global usage ============
	private(set) var globalManager: GlobalManagerProtocol!
	
	// MARK: - ================================= Overrided =================================
	override func register(container: Container, window: UIWindow) {
		super.register(container: container, window: window)
		
		container.register(MainServiceProtocol.self) { _ in MainService() }
		container.register(RegisterAppServiceProtocol.self) { _ in RegisterApp(container: container, window: window) }
		container.register(GlobalManagerProtocol.self) { _ in GlobalManagerService() }
	}
	
	override func initialize(container: Container) {
		super.initialize(container: container)
		
		return globalManager = container.sureResolve(GlobalManagerProtocol.self)
	}
	
	override func setupGlobalThings(from container: Container) {
		super.setupGlobalThings(from: container)
		
		let model = BaseModel()
		
		// Config for network
		let network = container.sureResolve(NetworkServiceProtocol.self)
		let dataStore = container.sureResolve(DataStoreServiceProtocol.self)
		let viewModel = AccountManagerViewModel(model: model,
												network: network,
												dataStore: dataStore)
		return globalManager
			.account
			.config(viewmodel: viewModel)
	}
}
