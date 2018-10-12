//
//  PasswordTextField.swift
//  ASHManager
//
//  Created by ToanNV11 on 12/29/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class PasswordTextField: UnderLineTextField {
	
	fileprivate var isSecure = true
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.customLayout()
	}
	
	fileprivate func customLayout() {
		isSecureTextEntry = isSecure
		rightViewMode = .never
	}
}
