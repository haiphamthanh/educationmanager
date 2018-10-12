//
//  AccountRegisterViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class AccountRegisterViewController: SliderPresentationViewController {
	// MARK: - ================================= Properties =================================
	private let slider: SliderFactory = SliderService()
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		showRegister()
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.titleRegisterUserInfomation()
	}
	
	override class func storyNameProvider() -> String {
		return AppStoryboard.basicInformation
	}
	
	override func configView(with dataSource: Any) {
		slider.configView(with: dataSource)
	}
}

// MARK: - ================================= Final =================================
extension AccountRegisterViewController: AccountRegisterViewProtocol {
}

// MARK: - ================================= Private =================================
private extension AccountRegisterViewController {
	var viewModel: AccountRegisterViewModelProtocol {
		return viewModelWraper(type: AccountRegisterViewModelProtocol.self)
	}
	
	func showRegister() {
		slider.showIn(viewController: self)
	}
}
