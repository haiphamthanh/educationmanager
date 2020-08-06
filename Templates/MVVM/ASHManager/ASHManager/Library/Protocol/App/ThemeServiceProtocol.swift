//
//  ThemeServiceProtocol.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

enum MyThemes: Int {
	case normal = 0
	case red
	case yello
	case blue
	case night
}

protocol ThemeServiceProtocol {
	static func switchTo(theme: MyThemes)
	static func switchToNext()
	
	// MARK: - Switch Night
	static func switchNight(isToNight: Bool)
	
	// MARK: - Save & Restore
	static func restoreLastTheme()
	static func saveLastTheme()
	
	static func applyAppearanceDefaults()
}
