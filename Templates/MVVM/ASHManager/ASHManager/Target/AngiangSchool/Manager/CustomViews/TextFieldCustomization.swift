//
//  TextFieldCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum TextFieldType: Int {
	case normal
	case date
	case password
}

@IBDesignable
class TextFieldCustomization: UITextField {
	@IBInspectable var viewType: Int = TextFieldType.normal.rawValue {
		didSet {
			guard let viewType = TextFieldType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: TextFieldType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
