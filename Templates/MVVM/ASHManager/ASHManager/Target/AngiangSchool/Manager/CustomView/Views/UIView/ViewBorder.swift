//
//  ViewBorder.swift
//  ASHManager
//
//  Created by KhoaLA on 3/14/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class ViewBorder: UIView {
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let rightBorder = CALayer()
		rightBorder.backgroundColor = UIColor.gray.cgColor
		rightBorder.frame = CGRect(x: frame.size.width - 3, y: 18, width: 2, height: frame.size.height/1.2)
		layer.addSublayer(rightBorder)
		
		let leftBorder = CALayer()
		leftBorder.backgroundColor = UIColor.gray.cgColor
		leftBorder.frame = CGRect(x: 0, y: 18, width: 2, height: frame.size.height/1.2)
		layer.addSublayer(leftBorder)
		
		clipsToBounds = true
	}
}

@IBDesignable
class CommentViewBorder: UIView {
	init(size:CGFloat = 200, roundess: CGFloat = 2, borderWidth: CGFloat = 2, borderColor: UIColor = UIColor.white){
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
	
	@IBInspectable var borderColor: UIColor = UIColor.lightGray {
		didSet{
			setNeedsLayout()
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
		layer.cornerRadius = roundness
		clipsToBounds = true
	}
}
