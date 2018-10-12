//
//  UnderLineLabel.swift
//  ASHManager
//
//  Created by HieuNT52 on 12/21/17.
//  Copyright © 2017 HieuNT52. All rights reserved.
//

import UIKit.UILabel

class UnderLineLabel: UILabel {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		addLineBorder(side: .Bottom, color: .white, width: 1.0)
		textColor = .white
		backgroundColor = .clear
	}
}

class GrayBorderPlaceholderRoundCornerLabel: UILabel {
	
	@IBInspectable var topInset: CGFloat = 5.0
	@IBInspectable var bottomInset: CGFloat = 5.0
	@IBInspectable var leftInset: CGFloat = 7.0
	@IBInspectable var rightInset: CGFloat = 7.0
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
	}
	
	override var intrinsicContentSize: CGSize {
		var intrinsicSuperViewContentSize = super.intrinsicContentSize
		intrinsicSuperViewContentSize.height += topInset + bottomInset
		intrinsicSuperViewContentSize.width += leftInset + rightInset
		return intrinsicSuperViewContentSize
	}
	
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
	
	@IBInspectable var roundness: CGFloat = 2 {
		didSet{
			setNeedsLayout()
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 2 {
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
	}
}
