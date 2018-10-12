//
//  LenghtTextField.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class LenghtTextField: ValueTextField {
	private static let maxLenght = 3
	private static let maxValue = 120
	private static let defaultValue = "00"
	private static let defaultDot = "."
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		keyboardType = UIKeyboardType.numberPad
		delegate = self
	}
}

extension LenghtTextField : UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentString: NSString = textField.text! as NSString
		let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
		let newData: String = newString as String
		
		if (newString.isEqual(to: "")) {
			return true
		}
		
		if (newData.contains(GKLenghtTextField.defaultDot)) {
			return false
		}
		
		if (Int(newData)! > GKLenghtTextField.maxValue || newData == GKLenghtTextField.defaultValue) {
			return false
		}
		
		return newString.length <= GKLenghtTextField.maxLenght
	}
}
