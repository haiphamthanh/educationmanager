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
	@IBOutlet private weak var agreeButton: UIButton!
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		agreeButton.setTitle(LocalizedString.titleAgree(), for: .normal)
		
		termsOfUseButton.setTitle(LocalizedString.titleTermsOfUse(), for: .normal)
		privacyPolicyButton.setTitle(LocalizedString.titlePrivacyPolicy(), for: .normal)
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
	
	// MARK: - ================================= Config view =================================
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
	
	func change(view: TermOfUseViewType) {
		viewModel.select(view: view)
	}
}
