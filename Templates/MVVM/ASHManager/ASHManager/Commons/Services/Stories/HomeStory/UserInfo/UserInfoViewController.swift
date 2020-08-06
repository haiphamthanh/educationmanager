//
//  UserInfoViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class UserInfoViewController: HomeBaseViewController {
	// MARK: - ================================= Outlet =================================
	
	// MARK: - ================================= Properties =================================
	
	// MARK: - ================================= Init =================================
	override var isNavBarHidden: Bool {
		return false
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.settingTittle()
	}
}

// MARK: - ================================= Final =================================
extension UserInfoViewController: UserInfoViewProtocol {
}

// MARK: - ================================= Private =================================
private extension UserInfoViewController {
}
