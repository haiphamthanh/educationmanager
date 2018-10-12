//
//  NextButton.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class NextButton: UIButton {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addColorBorder()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addColorBorder()
	}
	
	func addColorBorder(color: UIColor = .white, width: CGFloat = 2.0, cornerRadius: CGFloat = 4.0) {
		backgroundColor = .clear
		
		layer.masksToBounds = true
		layer.borderWidth = width
		layer.cornerRadius = cornerRadius
		layer.borderColor = color.cgColor
		
		titleLabel?.font = GKFont.value()
		setTitleColor(UIColor.white, for: .normal)
		setTitleColor(UIColor(red: 248/255, green: 139/255, blue: 96/255, alpha: 1.0), for: .highlighted)
	}
}
