//
//  GKCanShowPasswordTextField.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/5/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class CanShowPasswordTextField: UnderLineTextField {
	
	fileprivate var isSecure = true
	let showButton = UIButton()
	var eyeImage = "ic_eye_blind"
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.customLayout()
	}
	
	fileprivate func customLayout() {
		isSecureTextEntry = isSecure
		showButton.setImage(UIImage(named: eyeImage), for: .normal)
		showButton.contentMode = .scaleToFill
		showButton.addTarget(self, action: #selector(showClicked), for: .touchUpInside)
		rightView = showButton
		rightViewMode = .always
	}
	
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		let rightBounds = CGRect(x: bounds.size.width - 15, y: (bounds.size.height - 12) / 2, width: 15, height: 9)
		return rightBounds
	}
	
	@objc fileprivate func showClicked(sender: UIButton) {
		isSecure = !isSecure
		eyeImage = isSecure ? "ic_eye_blind" : "ic_eye"
		showButton.setImage(UIImage(named: eyeImage), for: .normal)
		isSecureTextEntry = isSecure
	}
}

