//
//  CircleLabel.swift
//  ASHManager
//
//  Created by 7i3u7u on 7/25/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class CircleLabel : AbstractLabel {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.borderWidth = 1.0
		layer.borderColor = UIColor.lightGray.cgColor
		layer.cornerRadius = self.frame.size.width/2
		layer.masksToBounds = true
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.header(with: .size15)
	}
}
