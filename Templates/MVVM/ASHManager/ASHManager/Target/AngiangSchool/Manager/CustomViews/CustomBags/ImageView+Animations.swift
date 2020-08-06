//
//  ImageView+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension ImageViewType {
	func relayoutView(_ sender: UIImageView) {
		switch self {
		case .normal:
			return normalCustom(sender)
		}
	}
}

// Private
private extension ImageViewType {
	func normalCustom(_ sender: UIImageView) {
	}
}
