//
//  AppFont.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit.UIFont

enum FontSize: Int {
	case buttonSize = 18
	case h1 = 16
	case h2 = 14
	case h3 = 12
	case h4 = 10
	case h5 = 8
	case h6 = 5
	case h7 = 9
	case body = 13
	case introTitleSize = 36
	case introContentSize = 17
	case size15 = 15
	case size20 = 20
	case size24 = 24
	case size30 = 30
}

enum AppFont: String {
	case meiryo_0 = "MEIRYO_0"
	case meiryob = "meiryob"
	case openSans_Bold = "OpenSans-Bold"
	case openSans_BoldItalic = "OpenSans-BoldItalic"
	case openSans_ExtraBold = "OpenSans-ExtraBold"
	case openSans_ExtraBoldItalic = "OpenSans-ExtraBoldItalic"
	case openSans_Italic = "OpenSans-Italic"
	case openSans_Light = "OpenSans-Light"
	case openSans_Regular = "OpenSans-Regular"
	case openSans_Semibold = "OpenSans-Semibold"
	case openSans_LightItalic = "OpenSans-LightItalic"
	case openSans_SemiboldItalic = "OpenSans-SemiboldItalic"
	
	func size(_ size: FontSize) -> UIFont {
		let size = CGFloat(size.rawValue)
		return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
	}
}

class GKFont {
	static func header(with fontSize: FontSize) -> UIFont {
		return AppFont.openSans_Semibold.size(fontSize)
	}
	
	static func body(with fontSize: FontSize = .body) -> UIFont {
		return AppFont.openSans_ExtraBold.size(fontSize)
	}
	
	static func value(with fontSize: FontSize = .body) -> UIFont {
		return AppFont.openSans_Bold.size(fontSize)
	}
	
	static func lightValue(with fontSize: FontSize = .body) -> UIFont {
		return AppFont.openSans_Light.size(fontSize)
	}
	
	static func regularValue(with fontSize: FontSize = .body) -> UIFont {
		return AppFont.openSans_Regular.size(fontSize)
	}
	
	static func valueBold(with fontSize: FontSize = .body) -> UIFont {
		return AppFont.openSans_Semibold.size(fontSize)
	}
}
