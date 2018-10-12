//
//  UnderLineUnablePasteTextField.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 3/19/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

class UnderlineUnablePasteTextField: UITextField {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		addLineBorder(side: .Bottom, color: .white, width: 1.0)
	}
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		if action == #selector(UIResponderStandardEditActions.paste(_:)) {
			return false
		}
		return super.canPerformAction(action, withSender: sender)
	}
}
