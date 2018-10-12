//
//  ViewModelAdapter.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ViewModelAdapter: BaseViewModel {
	// MARK: - ================================= Common properties =================================
	var userGetter: UserData? {
		return user
	}
	
	private var user: UserData?
	var userInfo: UserInfoData? {
		return user?.userInfo
	}
	var userHealth: HealthData? {
		return user?.health
	}
	var displayName: String {
		guard let userInfo = userInfo else {
			return ""
		}
		
		if let nickname = userInfo.nickName, !nickname.isEmpty {
			return nickname
		}
		
		if userInfo.first_name.isEmpty || userInfo.last_name.isEmpty {
			return userInfo.username
		}
		
		return "\(userInfo.first_name) \(userInfo.last_name)"
	}
	
	// MARK: - ================================= Init view =================================
	var gkModel: ModelAdapterProtocol {
		if let model = model as? ModelAdapterProtocol {
			return model
		}
		
		fatalError("Miss implement for ModelAdapterProtocol")
	}
	
	var gkNetworkService: NetworkManagerProtocol {
		if let networkService = networkService as? NetworkManagerProtocol {
			return networkService
		}
		
		fatalError("Miss implement for NetworkManagerProtocol")
	}
	
	override func initialize(params: Dictionary<String, Any>?) {
		super.initialize(params: params)
		
		user = loadUser()
	}
}

// MARK: - ================================= Final =================================
extension ViewModelAdapter: ViewModelAdapterProtocol {
}

// MARK: - ================================= Private =================================
private extension ViewModelAdapter {
	func loadUser() -> UserData? {
		return user
	}
}
