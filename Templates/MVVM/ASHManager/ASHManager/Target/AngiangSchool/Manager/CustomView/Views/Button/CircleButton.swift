//
//  CircleButton.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class CircleButton: AbstractButton {
	init(size: CGFloat = 200, roundess: CGFloat = 2, borderWidth: CGFloat = 2, borderColor: UIColor = UIColor.white){
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
		
		layer.cornerRadius = bounds.width / roundness
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
		clipsToBounds = true
		
		let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 20, dy: 20), cornerRadius: bounds.width / roundness)
		let mask = CAShapeLayer()
		
		mask.path = path.cgPath
		layer.mask = mask
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.valueBold(with: .introContentSize)
	}
}

class BorderButtom: UIButton {
	@IBInspectable var borderRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = borderRadius
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 0 {
		didSet {
			layer.borderWidth = borderWidth
		}
	}
	
	@IBInspectable var btnBorderColor: UIColor? {
		didSet {
			layer.borderColor = btnBorderColor?.cgColor
		}
	}
	
	@IBInspectable var background: UIColor? {
		didSet {
			backgroundColor = background
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = borderRadius
		layer.borderWidth = borderWidth
		layer.borderColor = btnBorderColor?.cgColor
		clipsToBounds = true
	}
}

class CircleBorderButtom: BorderButtom {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = frame.size.height / 2
		layer.borderWidth = borderWidth
		layer.borderColor = btnBorderColor?.cgColor
		clipsToBounds = true
	}
}
