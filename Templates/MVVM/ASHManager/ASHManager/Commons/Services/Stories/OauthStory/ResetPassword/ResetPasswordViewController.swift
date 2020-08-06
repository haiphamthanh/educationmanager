//
//  ResetPasswordViewController.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/5/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum InputResetPassword: Int {
	case pinCode = 1
	case newPassword
	case confirmPassword
	
	func textField(from superView: UIView) -> UITextField? {
		return superView.viewWithTag(rawValue) as? UITextField
	}
}

class ResetPasswordViewController: ViewControllerAdapter {
	// MARK: - ================================= Outlet =================================
	
	@IBOutlet private weak var pinCodeTxt: UITextField!
	@IBOutlet private weak var newPasswordTxt: UITextField!
	@IBOutlet private weak var confirmPasswordTxt: UITextField!
	
	@IBOutlet private weak var changePasswordBtn: UIButton!
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		pinCodeTxt.placeholder = LocalizedString.pincodeTittle()
		newPasswordTxt.placeholder = LocalizedString.passwordTittle()
		confirmPasswordTxt.placeholder = LocalizedString.confirmPasswordTittle()
		
		changePasswordBtn.setTitle(LocalizedString.changeButtonTittle(), for: .normal)
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
//		pinCodeTxt.rx
//			.text
//			.orEmpty
//			.bind(to: viewModel.pinCode)
//			.disposed(by: disposeBag)
//		
//		newPasswordTxt.rx
//			.text
//			.orEmpty
//			.bind(to: viewModel.newPassword)
//			.disposed(by: disposeBag)
//		
//		confirmPasswordTxt.rx
//			.text
//			.orEmpty
//			.bind(to: viewModel.confirmPassword)
//			.disposed(by: disposeBag)
		
		changePasswordBtn.rx
			.tap
			.bind { [weak self] in
				self?.viewModel.resetPassword()
			}.disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.titleResetPassword()
	}
}

// MARK: - ########################## Final ##########################
extension ResetPasswordViewController: ResetPasswordViewProtocol {
}

// MARK: - ================================= Private =================================
private extension ResetPasswordViewController {
	var viewModel: ResetPasswordViewModelProtocol {
		return viewModelWraper(type: ResetPasswordViewModelProtocol.self)
	}
	
	func relayout(title label: UILabel, of textField: UITextField) {
		UIView.animate(withDuration: 0.4,
					   delay: 0.0,
					   usingSpringWithDamping: 1.0,
					   initialSpringVelocity: 0.5,
					   options: .transitionFlipFromTop,
					   animations: {
						label.alpha = textField.text!.isEmpty ? 0.0 : 1.0
		})
	}
}
