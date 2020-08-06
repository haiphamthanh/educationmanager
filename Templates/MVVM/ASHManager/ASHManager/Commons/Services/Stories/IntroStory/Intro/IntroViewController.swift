//
//  IntroViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class IntroViewController: SliderPresentationViewController {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var loginButton: UIButton!
	@IBOutlet private weak var registerButton: UIButton!
	
	// MARK: - ================================= Properties =================================
	private let slider: SliderFactory = SliderService()
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		setupUI()
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
		loginButton.rx
			.tap
			.bind(to: viewModel.signIn)
			.disposed(by: disposeBag)
		
		registerButton.rx
			.tap
			.bind(to: viewModel.signUp)
			.disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config view =================================
}

// MARK: - ================================= Final =================================
extension IntroViewController: IntroViewProtocol {
}

// MARK: - ================================= Private =================================
private extension IntroViewController {
	var viewModel: IntroViewModelProtocol {
		return viewModelWraper(type: IntroViewModelProtocol.self)
	}
	
	func setupUI() {
		firstInit()
		showIntroView()
	}
	
	func firstInit() {
		loginButton.setTitle(LocalizedString.titleButtonLoginIntroduct(), for: .normal)
		registerButton.setTitle(LocalizedString.titleButtonRegisterIntroduct(), for: .normal)
	}
	
	func showIntroView() {
		slider.showIn(viewController: self)
	}
}
