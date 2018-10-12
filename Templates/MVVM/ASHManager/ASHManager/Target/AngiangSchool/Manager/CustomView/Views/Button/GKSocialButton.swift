//
//  GKSocialButton.swift
//  ASHManager
//
//  Created by KhoaLA on 5/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit.UIButton

class GKSocialButton : UIButton {
	
	@IBInspectable var radius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = radius
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel?.textAlignment = .center
	}
	
	override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		let size = contentRect.height - 30
		return CGRect(x: 15, y: 15, width: size, height: size)
	}
	
	override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
		let size = contentRect.height - 30
		return CGRect(x: size, y:0, width: self.bounds.size.width - self.imageRect(forContentRect:contentRect).width,height: contentRect.height)
	}
}
