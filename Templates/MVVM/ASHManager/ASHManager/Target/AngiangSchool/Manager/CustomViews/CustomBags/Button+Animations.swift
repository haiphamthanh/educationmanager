//
//  Button+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension ButtonCType {
	var color: UIColor {
		switch self {
		case .normal:
			return MyColors.buttonVioletColor
		case .white:
			return .white
		case .facebook:
			return MyColors.buttonBlueColor
		case .google:
			return MyColors.buttonOrangeColor
		}
	}
	
	func relayoutView(_ sender: UIButton) {
		switch self {
		case .normal:
			return violetCustom(sender)
		case .white:
			return whiteCustom(sender)
		case .facebook:
			return facebookCustom(sender)
		case .google:
			return googleCustom(sender)
		}
	}
}

// Private
private extension ButtonCType {
	func violetCustom(_ sender: UIButton) {
		return normalCustom(sender)
	}
	
	func whiteCustom(_ sender: UIButton) {
		return normalCustom(sender)
	}
	
	func facebookCustom(_ sender: UIButton) {
		return socialCustom(sender)
	}
	
	func googleCustom(_ sender: UIButton) {
		return socialCustom(sender)
	}
	
	private func socialCustom(_ sender: UIButton) {
		return normalCustom(sender)
	}
	
	private func normalCustom(_ sender: UIButton) {
		sender.titleLabel?.textAlignment = .center
		sender.backgroundColor = color
		sender.titleLabel?.textColor = .white
	}
}
