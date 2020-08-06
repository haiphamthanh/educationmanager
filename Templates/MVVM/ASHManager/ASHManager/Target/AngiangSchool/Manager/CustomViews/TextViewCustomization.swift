//
//  TextViewCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum TextViewType: Int {
	case normal = 0
	case link
	case lessmore
}

@IBDesignable
class TextViewCustomization: UITextView {
	@IBInspectable var viewType: Int = TextViewType.normal.rawValue {
		didSet {
			guard let viewType = TextViewType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: TextViewType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
