//
//  TextViewBorder.swift
//  ASHManager
//
//  Created by KhoaLA on 4/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class TextViewBorder: UITextView {
	@IBInspectable
	var cornerRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 0 {
		didSet {
			layer.borderWidth = borderWidth
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		didSet {
			layer.borderColor = borderColor?.cgColor
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = cornerRadius
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor?.cgColor
		clipsToBounds = true
	}
}
