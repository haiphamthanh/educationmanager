//
//  PickerView+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension PickerViewType {
	func relayoutView(_ sender: UIPickerView) {
		switch self {
		case .normal:
			return normalCustom(sender)
		}
	}
}

// Private
private extension PickerViewType {
	func normalCustom(_ sender: UIPickerView) {
	}
}
