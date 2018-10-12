//
//  MeasureTextField.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class MeasureTextField: ValueTextField {
	
	private static let defaultValue = "00"
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		delegate = self
	}
}

extension MeasureTextField: UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentString: NSString = textField.text! as NSString
		let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
		let newData: String = newString as String
		
		if (newString.isEqual(to: "")) {
			return true
		}
		
		if (newData == GKMeasureTextField.defaultValue) {
			return false
		}
		
		return true
	}
}
