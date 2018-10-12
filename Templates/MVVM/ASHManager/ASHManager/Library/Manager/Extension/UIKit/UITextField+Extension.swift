//
//  UITextField+Extension.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 3/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
	func doubleValue() -> Double {
		guard let valueTextField = self.text,
			let doubleValue = Double(valueTextField) else { return 0.0 }
		return doubleValue
	}
	
	func intValue() -> Int {
		guard let valueTextField = self.text,
			let intValue = Int(valueTextField) else { return 0 }
		return intValue
	}
	
	func configAttributed(placeholder: String) {
		attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
	}
}
