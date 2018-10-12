//
//  BaseViewController+Extension.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

// MARK: - ================================= Config view =================================
extension BaseViewController {
	static func newInstance() -> Self {
		return instantiateFromStoryboard(name: storyNameProvider())
	}
}

extension UIViewController {
	static func instantiateFromNib() -> Self {
		func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
			return T.init(nibName: String(describing: T.self), bundle: nil)
		}
		
		return instantiateFromNib(self)
	}
	
	static func instantiateFromStoryboard(name: String) -> Self {
		func instantiateFromStoryboard<T: UIViewController>(_ viewType: T.Type) -> T {
			let storyboard = UIStoryboard.init(name: name, bundle: nil)
			let vcName = String(describing: T.self)
			
			return storyboard.instantiateViewController(withIdentifier: vcName) as! T
		}
		
		return instantiateFromStoryboard(self)
	}
	
	func enableBackButton(enable: Bool) {
		navigationItem.setHidesBackButton(!enable, animated: false)
	}
	
	func enableNavigation(enable: Bool) {
		navigationController?.isNavigationBarHidden = !enable
	}
}
