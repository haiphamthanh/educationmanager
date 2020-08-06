//
//  LabelCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum LabelType: Int {
	case normal = 0
}

@IBDesignable
class LabelCustomization: UILabel {
	@IBInspectable var viewType: Int = LabelType.normal.rawValue {
		didSet {
			guard let viewType = LabelType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: LabelType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
