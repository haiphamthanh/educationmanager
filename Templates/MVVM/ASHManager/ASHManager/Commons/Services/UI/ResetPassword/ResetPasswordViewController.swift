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
	@IBOutlet private weak var pinCodeLbl: UILabel!
	@IBOutlet private weak var confirmPasswordLbl: UILabel!
	@IBOutlet private weak var newPasswordLbl: UILabel!
	
	@IBOutlet private weak var pinCodeTxt: UnderLineTextField!
	@IBOutlet private weak var newPasswordTxt: UnderLineTextField!
	@IBOutlet private weak var confirmPasswordTxt: UnderLineTextField!
	
	@IBOutlet private weak var changePasswordBtn: WhiteBorderButton!
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		pinCodeLbl.tag = InputResetPassword.pinCode.rawValue
		newPasswordLbl.tag = InputResetPassword.newPassword.rawValue
		confirmPasswordLbl.tag = InputResetPassword.confirmPassword.rawValue
		
		pinCodeLbl.alpha = 0.0
		newPasswordLbl.alpha = 0.0
		confirmPasswordLbl.alpha = 0
		
		pinCodeLbl.text = LocalizedString.pincodeTittle()
		newPasswordLbl.text = LocalizedString.passwordTittle()
		confirmPasswordLbl.text = LocalizedString.confirmPasswordTittle()
		
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
		return LocalizedString.titleForgotPassword()
	}
	
	override class func storyNameProvider() -> String {
		return AppStoryboard.auth
	}
	
	// MARK: - ================================= Action =================================
	@IBAction func editingTextField(_ sender: UnderLineTextField) {
		if let viewType = InputResetPassword(rawValue: sender.tag), let inputField = viewType.textField(from: view) {
			switch viewType {
			case .pinCode:
				relayout(title: pinCodeLbl, of: inputField)
			case .newPassword:
				relayout(title: newPasswordLbl, of: inputField)
			case .confirmPassword:
				relayout(title: confirmPasswordLbl, of: inputField)
			}
		}
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
