//
//  UnderLineTextField.swift
//  ASHManager
//
//  Created by HieuNT52 on 12/21/17.
//  Copyright © 2017 HieuNT52. All rights reserved.
//

import UIKit.UITextField

class UnderLineTextField: UITextField {
	
	@IBInspectable var fontSize: CGFloat = 12 {
		didSet {
			font = UIFont.systemFont(ofSize: fontSize)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		borderStyle = UITextBorderStyle.none
		layer.borderWidth = 0
		textColor = .white
		backgroundColor = .clear
		font = UIFont.systemFont(ofSize: fontSize)
		
		attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
	}
	
	let textPadding = UIEdgeInsets(top: 0, left: 10, bottom: -5, right: 10)
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addLineBorder(side: .Bottom, color: .white, width: 1.0)
	}
}

class GrayUnderLineTextField: UITextField {
	
	let color = Color.custom(hexString: "#BDBDBD").value
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		borderStyle = UITextBorderStyle.none
		layer.borderWidth = 0
		textColor = color
		backgroundColor = .clear
		font = UIFont.systemFont(ofSize: 17)
		textColor = .black
		
		attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
			NSAttributedStringKey.foregroundColor: color])
	}
	
	let textPadding = UIEdgeInsets(top: 0, left: 10, bottom: -6, right: 10)
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, textPadding)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addLineBorder(side: .Bottom, color: color, width: 1.0)
	}
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		if action == #selector(UIResponderStandardEditActions.paste(_:)) {
			return false
		}
		return super.canPerformAction(action, withSender: sender)
	}
}

class BlackUnderLineTextField: UITextField {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		borderStyle = UITextBorderStyle.none
		layer.borderWidth = 0
		textColor = .black
		backgroundColor = .clear
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		addLineBorder(side: .Bottom, color: .lightGray, width: 0.9)
	}
}


@IBDesignable
class GrayBorderPlaceholderRoundCorner: UITextField {
	init(size:CGFloat = 200, roundess:CGFloat = 2, borderWidth:CGFloat = 2, borderColor:UIColor = UIColor.white){
		roundness = roundess
		self.borderWidth = borderWidth
		self.borderColor = borderColor
		
		super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@IBInspectable var roundness: CGFloat = 0 {
		didSet{
			setNeedsLayout()
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 4 {
		didSet{
			setNeedsLayout()
		}
	}
	
	@IBInspectable var borderColor: UIColor = UIColor.white {
		didSet{
			setNeedsLayout()
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.borderColor = borderColor.cgColor
		layer.cornerRadius = roundness
		layer.masksToBounds = true
		
		attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
			NSAttributedStringKey.font: UIFont(name: "Georgia-Italic", size: 12)!,
			NSAttributedStringKey.foregroundColor: UIColor.darkGray])
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
	}
}
