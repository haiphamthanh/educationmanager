//
//  AbstractTextView.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class AbstractTextView : UITextView {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		font = fontProvider()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		font = fontProvider()
	}
	
	func fontProvider() -> UIFont {
		fatalError("This is abstract class")
	}
}
