//
//  DialogButton.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/15/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import PopupDialog

enum DialogButtonType: Int {
	case normal = 0
	case cancel
	case destructive
	case other
}

class DialogButton {
	class func button(title: String, type: DialogButtonType, action: (() -> Void)? = nil) -> PopupDialogButton {
		switch type {
		case .normal:
			return normalButton(title: title, action: action)
		case .cancel:
			return cancelButton(title: title, action: action)
		case .destructive:
			return destructiveButton(title: title, action: action)
		default:
			return otherButton(title: title, action: action)
		}
	}
	
	// MARK: - ================================= Private =================================
	private class func normalButton(title: String, action: (() -> Void)?) -> PopupDialogButton {
		return DefaultButton(title: title, action: action)
	}
	
	private class func cancelButton(title: String, action: (() -> Void)?) -> PopupDialogButton {
		return CancelButton(title: title, action: action)
	}
	
	private class func destructiveButton(title: String, action: (() -> Void)?) -> PopupDialogButton {
		return DestructiveButton(title: title, action: action)
	}
	
	private class func otherButton(title: String, action: (() -> Void)?) -> PopupDialogButton {
		return DefaultButton(title: title, action: action)
	}
	
	private static let padding = CGFloat(10.0)
	private class func normalButton(title: String, image: UIImage, font: UIFont, color: UIColor, action: (() -> Void)?) -> PopupDialogButton {
		let button = DefaultButton(title: title, action: action)
		button.setTitle(title, for: .normal)
		button.setImage(image, for: .normal)
		
		button.titleEdgeInsets = UIEdgeInsetsMake(0, padding, 0, -padding)
		button.contentEdgeInsets = UIEdgeInsetsMake(padding, 0, padding, 0)
		button.titleFont = font
		button.titleColor = color
		
		return button
	}
}
