//
//  ImageViewCustomization.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum ImageViewType: Int {
	case normal = 0
}

@IBDesignable
class ImageViewCustomization: UIImageView {
	@IBInspectable var viewType: Int = ImageViewType.normal.rawValue {
		didSet {
			guard let viewType = ImageViewType(rawValue: self.viewType) else {
				return
			}
			
			switchView(type: viewType)
		}
	}
	
	func switchView(type: ImageViewType) {
		type.relayoutView(self)
		setNeedsDisplay()
	}
}
