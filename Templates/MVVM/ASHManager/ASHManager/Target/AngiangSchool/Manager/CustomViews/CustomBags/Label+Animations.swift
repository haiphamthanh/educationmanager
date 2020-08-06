//
//  Label+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension LabelType {
	func relayoutView(_ sender: UILabel) {
		switch self {
		case .normal:
			return normalCustom(sender)
		}
	}
}

// Private
private extension LabelType {
	func normalCustom(_ sender: UILabel) {
	}
}
