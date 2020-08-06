//
//  PickerViewCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum PickerViewType: Int {
	case normal = 0
}

@IBDesignable
class PickerViewCustomization: UIPickerView {
	@IBInspectable var viewType: Int = PickerViewType.normal.rawValue {
		didSet {
			guard let viewType = PickerViewType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: PickerViewType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
