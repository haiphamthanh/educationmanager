//
//  WhiteBorderButton.swift
//  ASHManager
//
//  Created by HieuNT52 on 12/21/17.
//  Copyright © 2017 HieuNT52. All rights reserved.
//

import UIKit.UIButton

class WhiteBorderButton: UIButton {
	@IBInspectable var isClearBg: Bool = true
	@IBInspectable var boderColor: UIColor = .white
	@IBInspectable var boderWidth: CGFloat = 2.0
	@IBInspectable var cornerRadius: CGFloat = 4.0
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		setupView()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	private func setupView() {
		if isClearBg {
			backgroundColor = .clear
		}
		
		addBorder(color: boderColor, width: boderWidth, cornerRadius: cornerRadius)
	}
}

extension UIButton {
	func addBorder(color: UIColor = .white, width: CGFloat = 2.0, cornerRadius: CGFloat = 4.0) {
		titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
		setTitleColor(color, for: .normal)
		
		layer.masksToBounds = true
		layer.borderWidth = width
		layer.cornerRadius = cornerRadius
		layer.borderColor = color.cgColor
	}
	
	func setEnable(_ enable: Bool) {
		isEnabled = enable
		alpha = enable ? 1 : 0.7
	}
}

extension UIImageView {
	func setEnable(_ enable: Bool) {
		isUserInteractionEnabled = enable
		alpha = enable ? 1 : 0.7
	}
	
	func enable(_ enable: Bool, enableColor: UIColor) {
		isUserInteractionEnabled = enable
		image = enable ? image?.maskWithColor(color: enableColor) : image?.maskWithColor(color: UIColor("#A2A2A2"))
	}
}
