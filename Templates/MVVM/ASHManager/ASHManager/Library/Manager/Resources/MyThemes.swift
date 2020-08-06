//
//  MyThemes.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension MyThemes {
	static func applyAppearanceDefaults() {
		UITextField.appearance().keyboardAppearance = .dark
		UITextField.appearance().textColor = .black
		UITextField.appearance().backgroundColor = MyColors.boldColor
		
		UINavigationBar.appearance().barStyle = .black
		UINavigationBar.appearance().barTintColor = MyColors.textColor
		UINavigationBar.appearance().tintColor = MyColors.linkColor
		UINavigationBar.appearance().backgroundColor = MyColors.darkerColor
		
		UINavigationBar.appearance().barTintColor = MyColors.statusColor
		UINavigationBar.appearance().tintColor = UIColor.white
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
		
		let image = UIImage(color: .black,
							size: CGSize(width: 1.0, height: 1.0)).resizableImage(withCapInsets: .zero, resizingMode: .tile)
		UINavigationBar.appearance().shadowImage = image
		UINavigationBar.appearance().isTranslucent = false
		
		UIButton.appearance().tintColor = MyColors.textColor
		UILabel.appearance().tintColor = MyColors.textColor
		
		UISearchBar.appearance().backgroundColor = MyColors.darkColor
		UISearchBar.appearance().barTintColor = MyColors.darkColor
		UISearchBar.appearance().searchBarStyle = .minimal
		UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = MyColors.lightColor
		
		UILabel.appearance(whenContainedInInstancesOf: [UILabel.self]).textColor = MyColors.textColor
		UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [UIActivityIndicatorView.self]).style = .whiteLarge
	}
	
	static private func emptyView(withBackground color: UIColor) -> UIView {
		let view = UIView()
		view.backgroundColor = color
		return view
	}
}
