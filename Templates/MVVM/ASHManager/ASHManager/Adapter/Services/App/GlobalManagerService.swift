//
//  GlobalManagerService.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/18/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class GlobalManagerService: GlobalManagerProtocol {
	let appSetup: AppSetupProtocol
	let loadingView: LoadingManagerProtocol
	let account: AccountManagerProtocol
	let popup: PopUpProtocol
	
	// MARK: - ================================= Make sure everything is mapped =================================
	init(appSetup: AppSetupProtocol = AppSetup.sharedState,
		 loadingView: LoadingManagerProtocol = LoadingManager.shared,
		 account: AccountManagerProtocol = AccountManager.shared,
		 popup: PopUpProtocol = PopUpManager.shared) {
		
		self.appSetup = appSetup
		self.loadingView = loadingView
		self.account = account
		self.popup = popup
	}
}
