//
//  GenkNavigationViewController.swift
//  InitialProject
//
//  Created by Developer on 12/21/17.
//  Copyright © 2017 HieuNT52. All rights reserved.
//

import UIKit

class ExNavigationController: UINavigationController {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		
		transparentNavigationBar()
		setFontTitle()
	}
	
	private func transparentNavigationBar() {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
	}
	
	private func setFontTitle() {
		navigationBar.tintColor = .white
		navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
	}
}
