//
//  AbstractButton.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class AbstractButton : WhiteBorderButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		titleLabel?.font = fontProvider()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		titleLabel?.font = fontProvider()
	}
	
	func fontProvider() -> UIFont {
		fatalError("This is abstract class")
	}
}
