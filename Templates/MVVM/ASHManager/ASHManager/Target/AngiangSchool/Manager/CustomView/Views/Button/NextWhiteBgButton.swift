//
//  NextWhiteBgButton.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class NextWhiteBgButton: UIButton {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addBorder()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addBorder()
	}
	
	func addBorder() {
		backgroundColor = .clear
		layer.masksToBounds = true
		
		titleLabel?.font = GKFont.value()
		setTitleColor(UIColor.white, for: .normal)
		setTitleColor(UIColor(red: 248/255, green: 139/255, blue: 96/255, alpha: 1.0), for: .highlighted)
	}
}
