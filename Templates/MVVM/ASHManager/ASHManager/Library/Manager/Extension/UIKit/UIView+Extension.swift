//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit.UIView

enum UIButtonBorderSide {
	case Top, Bottom, Left, Right
}

extension UIView {
	class func loadNib() -> Self {
		return loadNib(self)
	}
	
	class func loadNib(with frame: CGRect) -> Self {
		return loadNib(self, with: frame)
	}
	
	func addLineBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor
		
		switch side {
		case .Top:
			border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
		case .Bottom:
			border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
		case .Left:
			border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
		case .Right:
			border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
		}
		
		layer.addSublayer(border)
	}
	
	func shadowView(withOffset: CGSize, shadowOpacity: Float = 0.2, shadowRadius: CGFloat = 1, cornerRadius: CGFloat = 1) {
		self.layer.cornerRadius = cornerRadius
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = shadowOpacity
		self.layer.shadowOffset = withOffset
		self.layer.shadowRadius = shadowRadius
	}
	
	func makingCircle() {
		layer.cornerRadius = self.frame.size.height / 2
		layer.masksToBounds = true
	}
	
	func makingCornerRadius(degree: CGFloat) {
		layer.cornerRadius = degree
		layer.masksToBounds = true
	}
	
	func addLighterShadow(){
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.3
		self.layer.shadowRadius = 1.0
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
	}
	
	private class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
		let className = String.className(viewType)
		return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
	}
	
	private class func loadNib<T: UIView>(_ viewType: T.Type, with frame: CGRect) -> T {
		let className = String.className(viewType)
		var nibFile = Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
		nibFile.frame = frame
		
		return nibFile
	}
}
