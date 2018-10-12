//
//  IconTextField.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 4/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class IconTextField: UITextField {
	
	fileprivate var isSecure = true
	let showButton = UIButton()
	var eyeImage = "ic_eye_blind"
	
	@IBInspectable var leftImage: UIImage? {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var leftPadding: CGFloat = 0
	
	@IBInspectable var underlineColor: UIColor = .white
	
	@IBInspectable var placeholderColor: UIColor = .white
	
	@IBInspectable var colorEyeImage: UIColor = .black {
		didSet {
			customLayout()
		}
	}
	
	@IBInspectable var isPassword: Bool = false {
		didSet {
			if isPassword {
				customLayout()
			}
		}
	}
	
	@IBInspectable var color: UIColor = UIColor.white {
		didSet {
			updateView()
		}
	}
	
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.leftViewRect(forBounds: bounds)
		textRect.origin.x += leftPadding
		return textRect
	}
	
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		let rightBounds = CGRect(x: bounds.size.width - 15, y: (bounds.size.height - 12) / 2, width: 15, height: 9)
		return rightBounds
	}
	
	fileprivate func customLayout() {
		isSecureTextEntry = isSecure
		let image = UIImage(named: eyeImage)?.maskWithColor(color: colorEyeImage)
		showButton.setImage(image, for: .normal)
		showButton.contentMode = .scaleToFill
		showButton.addTarget(self, action: #selector(showClicked), for: .touchUpInside)
		rightView = showButton
		rightViewMode = .always
	}
	
	@objc fileprivate func showClicked(sender: UIButton) {
		isSecure = !isSecure
		eyeImage = isSecure ? "ic_eye_blind" : "ic_eye"
		let image = UIImage(named: eyeImage)?.maskWithColor(color: colorEyeImage)
		showButton.setImage(image, for: .normal)
		isSecureTextEntry = isSecure
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addLineBorder(side: .Bottom, color: underlineColor, width: 1.0)
		backgroundColor = .clear
		borderStyle = .none
	}
	
	fileprivate func updateView() {
		if let image = leftImage {
			leftViewMode = UITextFieldViewMode.always
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
			imageView.contentMode = .left
			imageView.image = image.maskWithColor(color: color)
			// Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
			imageView.tintColor = color
			leftView = imageView
		} else {
			leftViewMode = UITextFieldViewMode.never
			leftView = nil
		}
		
		// Placeholder text color
		attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: placeholderColor])
	}
}
