//
//  TermOfUseViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class TermOfUseViewController: ViewControllerAdapter {
	// MARK: - ================================= Properties =================================
	@IBOutlet private weak var termsOfUseButton: UIButton!
	@IBOutlet private weak var privacyPolicyButton: UIButton!
	@IBOutlet private weak var termPolicyTextView: UITextView!
	@IBOutlet private weak var agreeButton: GKOrangeButton!
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		agreeButton.setTitle(LocalizedString.titleAgree(), for: .normal)
		
		termsOfUseButton.setTitle(LocalizedString.titleTermsOfUse(), for: .normal)
		privacyPolicyButton.setTitle(LocalizedString.titlePrivacyPolicy(), for: .normal)
		
		view.backgroundColor = UIColor("#F2F2F2")
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
		termsOfUseButton.rx
			.tap
			.bind { [weak self] in
				self?.change(view: .termOfUse)
			}.disposed(by: disposeBag)
		
		privacyPolicyButton.rx
			.tap
			.bind { [weak self] in
				self?.change(view: .policy)
			}.disposed(by: disposeBag)
		
		agreeButton.rx
			.tap
			.bind(to: viewModel.agreeTermOfUse)
			.disposed(by: disposeBag)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		UIApplication.shared.statusBarStyle = .default
		loadNavigationBar(titleColor: UIColor.black, barColor: UIColor("#F2743B"))
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		UIApplication.shared.statusBarStyle = .lightContent
		loadNavigationBar(titleColor: UIColor.white, barColor: UIColor.white)
	}
	
	// MARK: - ================================= Config view =================================
	override var isGradientBg: Bool {
		return false
	}
	
	override class func storyNameProvider() -> String {
		return AppStoryboard.auth
	}
	
	override func configView(with dataSource: Any) {
		if let dataSource = dataSource as? TermOfUseViewData {
			switchView(with: dataSource)
		}
	}
}

// MARK: - ================================= Final =================================
extension TermOfUseViewController: TermOfUseViewProtocol {
}

// MARK: - ================================= Private =================================
private extension TermOfUseViewController {
	var viewModel: TermOfUseViewModelProtocol {
		return viewModelWraper(type: TermOfUseViewModelProtocol.self)
	}
	
	func switchView(with data: TermOfUseViewData) {
		let type = data.viewType
		let content = data.content
		
		switch type {
		case .policy:
			termsOfUseButton.tintColor = UIColor.gray
			privacyPolicyButton.tintColor = UIColor.blue
			title = LocalizedString.titlePrivacyPolicy()
		case .termOfUse:
			termsOfUseButton.tintColor = UIColor.blue
			privacyPolicyButton.tintColor = UIColor.gray
			title = LocalizedString.titleTermsOfUse()
		}
		
		termPolicyTextView.text = content
		termPolicyTextView.scrollRangeToVisible(NSMakeRange(0, 0))
	}
	
	func loadNavigationBar(titleColor: UIColor, barColor: UIColor) {
		navigationController?.navigationBar.tintColor = barColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : titleColor]
	}
	
	func change(view: TermOfUseViewType) {
		viewModel.select(view: view)
	}
}
