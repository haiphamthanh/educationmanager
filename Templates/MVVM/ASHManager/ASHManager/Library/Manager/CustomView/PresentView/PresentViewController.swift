//
//  PresentViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/03/13.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

class PresentViewController: ViewControllerAdapter {
	
	var didSaveClicked: ((_ viewController: Any?) -> ())?
	var presentationViewController: UIViewController!
	private var titleString: String = ""
	private var titleColor: UIColor = .white
	private var barColor: UIColor = .white
	override class func storyNameProvider() -> String {
		return "Present"
	}
	
	override func rightButtons() -> [UIBarButtonItem]? {
		var rightButtons = super.rightButtons()
		
		let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneAction))
		rightButtons?.append(rightButton)
		
		return rightButtons
	}
	
	func loadTitleWithColor(titleStr: String, titleColor: UIColor, barColor: UIColor) {
		self.titleString = titleStr
		self.titleColor = titleColor
		self.barColor = barColor
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		title = titleString
		navigationController?.navigationBar.tintColor = barColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : titleColor]
		
		if presentationViewController != nil {
			resetupLayout(presentationView: presentationViewController.view)
		}
	}
	
	@available(iOS 11.0, *)
	override func viewSafeAreaInsetsDidChange() {
		super.viewSafeAreaInsetsDidChange()
		
		if presentationViewController != nil {
			resetupLayout(presentationView: presentationViewController.view)
		}
	}
	
	private func resetupLayout(presentationView: UIView) {
		if #available(iOS 11.0, *) {
			let inset = view.safeAreaInsets
			presentationView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height - inset.top - inset.bottom)
			presentationView.frame.origin = CGPoint(x: view.bounds.origin.x, y: inset.top)
		} else {
			if let inset = navigationController?.navigationBar.frame {
				presentationView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height - inset.height - inset.origin.y)
				presentationView.frame.origin = CGPoint(x: view.bounds.origin.x, y: inset.height + inset.origin.y)
			}
		}
		
		if let layer = view.layer.sublayers?.first as? CAGradientLayer {
			layer.removeFromSuperlayer()
			view.backgroundColor = UIColor(AppColor.appNavigationBarColor)
		}
	}
	
	final func presentView(presentationView: UIView, presentationVC: UIViewController? = nil) {
		self.presentationViewController = presentationVC
		view.addSubview(presentationView)
		presentationView.center = view.center
	}
	
	@objc final func doneAction() {
		if let didSave = didSaveClicked {
			didSave(presentationViewController)
		}
	}
	
	final func disableSaveButton() {
		navigationItem.setRightBarButtonItems([], animated: true)
	}
}
