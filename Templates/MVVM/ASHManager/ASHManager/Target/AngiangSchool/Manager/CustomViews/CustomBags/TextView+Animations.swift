//
//  TextView+Animations.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension TextViewType {
	func relayoutView(_ sender: UITextView) {
		switch self {
		case .normal:
			return normalCustom(sender)
		case .link:
			return linkCustom(sender)
		case .lessmore:
			return lessmoreCustom(sender)
		}
	}
}

// Private
private extension TextViewType {
	func normalCustom(_ sender: UITextView) {
	}
	
	func linkCustom(_ sender: UITextView) {
	}
	
	func lessmoreCustom(_ sender: UITextView) {
	}
}
