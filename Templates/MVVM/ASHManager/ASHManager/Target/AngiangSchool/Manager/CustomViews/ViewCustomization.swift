//
//  ViewCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum ViewType: Int {
	case normal
	case gradient
}

@IBDesignable
class ViewCustomization: UIView {
	@IBInspectable var viewType: Int = ViewType.normal.rawValue {
		didSet {
			guard let viewType = ViewType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: ViewType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
