//
//  CircleImageView.swift
//  ASHManager
//
//  Created by ToanNV11 on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
	
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
		
		layer.cornerRadius = bounds.width / roundness
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
		clipsToBounds = true
		
		let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: bounds.width / roundness)
		let mask = CAShapeLayer()
		
		mask.path = path.cgPath
		layer.mask = mask
	}
}
