//
//  ViewModelAdapter.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ViewModelAdapter: BaseViewModel, ViewModelAdapterProtocol {
}

// MARK: - ================================= View - Outputs =================================
extension ViewModelAdapter {
	var userCatched: Observable<UserData> {
		return AppDelegate.shared()
			.globalManager
			.account
			.bringMeNewUserInfo()
	}
}

// MARK: - ================================= Getter =================================
extension ViewModelAdapter {
	var userDisplayName: String {
		return usernameNormalized
	}
	
	var accountInfo: (isSigned: Bool, user: UserData?) {
		return AppDelegate.shared()
			.globalManager
			.account
			.signInInfo()
	}
}

// MARK: - ================================= Private =================================
private extension ViewModelAdapter {
	var usernameNormalized: String {
		guard let userInfo = accountInfo.user?.userInfo else {
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
}
