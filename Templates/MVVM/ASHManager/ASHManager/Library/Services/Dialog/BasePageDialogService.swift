//
//  BasePageDialogService.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/7/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import PopupDialog

class BasePageDialogService {
	private var navigationService: BasicNavigationServiceProtocol!
}

extension BasePageDialogService: PageDialogServiceProtocol {
	// MARK: - ================================= Init =================================
	func use(navigationService: BasicNavigationServiceProtocol) {
		self.navigationService = navigationService
	}
	
	// MARK: - ================================= Action =================================
	
	/// <#Description#>
	///
	/// - Parameters:
	///   - message: <#message description#>
	///   - cancelTitle: <#cancelTitle description#>
	///   - action: <#action description#>
	/// - Returns: <#return value description#>
	func show(message: PageDialogMessage) {
		// Create the dialog
		let popup = PopupDialog(title: message.title,
								message: message.message,
								buttonAlignment: .horizontal,
								transitionStyle: .zoomIn,
								gestureDismissal: true,
								hideStatusBar: true) {
									print("Completed")
		}
		
		guard let buttons = message.buttons else { return }
		
		for buttonData in buttons {
			guard let buttonType = buttonData.type else { continue }
			let button = DialogButton.button(title: buttonData.title,
											 type: buttonType,
											 action: buttonData.action)
			button.titleColor = buttonData.titleColor
			button.backgroundColor = buttonData.bgColor
			button.titleFont = UIFont.boldSystemFont(ofSize: buttonData.fontSize!)
			popup.addButton(button)
		}
		
		// Present dialog
		navigationService.presentViewController(viewController: popup, animated: true, completion: nil)
	}
	
	/// <#Description#>
	///
	/// - Parameters:
	///   - viewController: <#viewController description#>
	///   - buttonAlignment: <#buttonAlignment description#>
	///   - transitionStyle: <#transitionStyle description#>
	///   - preferredWidth: <#preferredWidth description#>
	///   - gestureDismissal: <#gestureDismissal description#>
	func show(vcType: PopUpViewControllerType,
			  params: Dictionary<String, Any>?,
			  buttonAlignment: UILayoutConstraintAxis,
			  transitionStyle: PopupDialogTransitionStyle,
			  preferredWidth: CGFloat?,
			  gestureDismissal: Bool,
			  confirmButtons: Bool) {
		
		guard let vc = vcType.vc(params: params) else { return }
		
		let popup = PopupDialog(viewController: vc,
								buttonAlignment: buttonAlignment,
								transitionStyle: transitionStyle,
								gestureDismissal: gestureDismissal)
		if confirmButtons {
			let ok = DialogButton.button(title: LocalizedString.localizedString(input: "Keyboard.Button.OK"),
										 type: .normal) { vc.ok() }
			ok.backgroundColor = UIColor("#FD9426")
			ok.titleColor = UIColor.white
			
			let cancel = DialogButton.button(title: LocalizedString.localizedString(input: "Keyboard.Button.OK"),
											 type: .destructive)
			cancel.backgroundColor = UIColor("#FD9426")
			cancel.titleColor = UIColor.white
			
			popup.addButtons([ok, cancel])
		}
		
		navigationService.presentViewController(viewController: popup, animated: true, completion: nil)
	}
	
	func show(vcType: PopUpViewControllerType,
			  params: Dictionary<String, Any>?,
			  confirmButtons: Bool) {
		show(vcType: vcType,
			 params: params,
			 buttonAlignment: .horizontal,
			 transitionStyle: .bounceDown,
			 preferredWidth: 14,
			 gestureDismissal: true,
			 confirmButtons: confirmButtons)
	}
	
	/// <#Description#>
	///
	/// - Parameters:
	///   - view: <#view description#>
	///   - buttonAlignment: <#buttonAlignment description#>
	///   - transitionStyle: <#transitionStyle description#>
	///   - preferredWidth: <#preferredWidth description#>
	///   - gestureDismissal: <#gestureDismissal description#>
	func show(view: UIView,
			  buttonAlignment: UILayoutConstraintAxis,
			  transitionStyle: PopupDialogTransitionStyle,
			  preferredWidth: CGFloat?,
			  gestureDismissal: Bool) {
		
		let vc = UIViewController.init()
		vc.view.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height - 100))
		addSubView(view, to: vc.view)
		
		let popup = PopupDialog(viewController: vc,
								buttonAlignment: buttonAlignment,
								transitionStyle: transitionStyle,
								gestureDismissal: gestureDismissal)
		navigationService.presentViewController(viewController: popup, animated: true, completion: nil)
	}
	
	/// <#Description#>
	///
	/// - Parameter completion: <#completion description#>
	func dismiss(_ completion: (() -> Void)?) {
		navigationService.dismissViewControllerAnimated(animated: true, completion: completion)
	}
	
	// MARK: - ================================= private =================================
	private func addSubView(_ subView: UIView, to view: UIView) {
		view.addSubview(subView)
		let viewsDict = [
			"subView": subView
		]
		let vflDict = [
			"H:|-0-[subView]-0-|",
			"V:|-0-[subView]-0-|"
		]
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vflDict[0] as String,
														   options: [], metrics: nil, views: viewsDict))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vflDict[1] as String,
														   options: [], metrics: nil, views: viewsDict))
	}
}
