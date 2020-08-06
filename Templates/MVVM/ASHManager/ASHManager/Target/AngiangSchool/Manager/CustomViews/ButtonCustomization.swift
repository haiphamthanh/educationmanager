//
//  ButtonCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum ButtonCType: Int {
	case normal = 0
	case white
	// Social
	case facebook
	case google
}

@IBDesignable
class ButtonCustomization: UIButton {
	@IBInspectable var viewType: Int = ButtonCType.normal.rawValue {
		didSet {
			guard let viewType = ButtonCType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: ButtonCType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
