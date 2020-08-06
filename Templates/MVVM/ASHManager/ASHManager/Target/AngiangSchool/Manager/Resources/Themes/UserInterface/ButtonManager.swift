//
//  ButtonManager.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

/// Used screens
///
class ButtonManager: ButtonCustomization {
}

/// Used screens
///
class ASEVioletButton: ButtonManager {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		viewType = ButtonCType.normal.rawValue
	}
}

/// Used screens
///
class ASEFacebookButton: ButtonManager {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		viewType = ButtonCType.facebook.rawValue
	}
}

/// Used screens
///
class ASEGoogleButton: ButtonManager {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		viewType = ButtonCType.google.rawValue
	}
}
