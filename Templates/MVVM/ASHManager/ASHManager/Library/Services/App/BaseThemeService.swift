//
//  BaseThemeService.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class BaseThemeService {
	class func appearanceDefaults() {
		return MyThemes.applyAppearanceDefaults()
	}
}

// MARK: - ########################## Final ##########################
extension BaseThemeService: ThemeServiceProtocol {
	static func switchTo(theme: MyThemes) {
		// TODO: Tobe define
		//		MyThemes.switchTo(theme: theme)
	}
	
	static func switchToNext() {
		// TODO: Tobe define
		//		MyThemes.switchToNext()
	}
	
	static func switchNight(isToNight: Bool) {
		// TODO: Tobe define
		//		MyThemes.switchNight(isToNight: isToNight)
	}
	
	static func restoreLastTheme() {
		// TODO: Tobe define
		//		MyThemes.restoreLastTheme()
	}
	
	static func saveLastTheme() {
		// TODO: Tobe define
		//		MyThemes.saveLastTheme()
	}
	
	static func applyAppearanceDefaults() {
		return appearanceDefaults()
	}
}
