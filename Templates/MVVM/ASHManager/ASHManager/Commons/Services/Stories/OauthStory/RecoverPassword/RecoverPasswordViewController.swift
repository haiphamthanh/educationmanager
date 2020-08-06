//
//  RecoverPasswordViewController
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class RecoverPasswordViewController: ViewControllerAdapter {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var logoImageView: UIImageView!
	@IBOutlet private weak var titleLable: UILabel!
	@IBOutlet private weak var contentLabel: UILabel!
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var sendButton: UIButton!
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		titleLable.text = LocalizedString.resetPassLableTitle()
		titleLable.font = UIFont.boldSystemFont(ofSize: 14)
		
		contentLabel.text = LocalizedString.resetPassContent()
		contentLabel.font = UIFont.boldSystemFont(ofSize: 14)
		
		sendButton.setTitle(LocalizedString.resetPassSendButtonTitle(), for: .normal)
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
		sendButton.rx
			.tap
			.bind { [weak self] in
				self?.sendCodeToResetPassword()
			}
			.disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.titleForgotPassword()
	}
}

// MARK: - ########################## Final ##########################
extension RecoverPasswordViewController: RecoverPasswordViewProtocol {
}

// MARK: - ================================= Private =================================
private extension RecoverPasswordViewController {
	var viewModel: RecoverPasswordViewModelProtocol {
		return viewModelWraper(type: RecoverPasswordViewModelProtocol.self)
	}
	
	func sendCodeToResetPassword() {
		guard let email = emailTextField.text else {
			return
		}
		
		viewModel.sendCode(toEmail: email)
	}
}
