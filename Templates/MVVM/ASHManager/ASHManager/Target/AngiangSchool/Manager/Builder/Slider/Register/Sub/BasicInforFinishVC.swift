//
//  BasicInforFinishVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BasicInforFinishVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var finishImageView: UIImageView!
	@IBOutlet private weak var finishTextView: GKLargerTextView!
	@IBOutlet private(set) weak var registerButton: GKNextButton!
	@IBOutlet private weak var indicator: UIActivityIndicatorView!
	@IBOutlet private weak var titleTextView: GKLargerTextView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforFinishVC {
	func startProcess() -> Observable<Void> {
		indicator.isHidden = false
		indicator.startAnimating()
		
		return Observable.empty()
	}
	
	func process(error: (() -> Void)? = nil, success: (() -> Void)? = nil) {
		if let error = error {
			return processError(on: error)
		}
		
		if let success = success {
			return completed(on: success)
		}
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforFinishVC {
	func subviewsSetup() {
		registerButton.setTitle(LocalizedString.titleRegisterUserInfomation(), for: .normal)
		titleTextView.text = LocalizedString.registerNotiTitle()
		finishImageView.isHidden = true
		indicator.isHidden = true
	}
	
	func subcribeSetup() {
	}
	
	func processError(on completion: @escaping (() -> Void)) {
		indicator.stopAnimating()
		registerButton.isHidden = false
		completion()
	}
	
	func completed(on completion: @escaping (() -> Void)) {
		registerButton.isHidden = true
		finishTextView.text = LocalizedString.finishNotiTitle()
		finishImageView.isHidden = false
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
			self?.indicator.stopAnimating()
			
			completion()
		}
	}
}
