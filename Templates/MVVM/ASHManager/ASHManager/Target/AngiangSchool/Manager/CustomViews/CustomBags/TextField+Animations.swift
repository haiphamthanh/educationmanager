//
//  TextField+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension TextFieldType {
	func relayoutView(_ sender: UITextField) {
		switch self {
		case .normal:
			return normalCustom(sender)
		case .date:
			return dateCustom(sender)
		case .password:
			return passwordCustom(sender)
		}
	}
}

// Private
private extension TextFieldType {
	func normalCustom(_ sender: UITextField) {
	}
	
	func dateCustom(_ sender: UITextField) {
	}
	
	func passwordCustom(_ sender: UITextField) {
	}
}
