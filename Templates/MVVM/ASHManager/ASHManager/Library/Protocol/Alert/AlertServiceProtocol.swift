//
//  AlertServiceProtocol.swift
//  ASEducation
//
//  Created by 7i3u7u on 11/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import PopupDialog

struct AlertInput {
	let title: String?
	let message: String
	let buttonAlignment: NSLayoutConstraint.Axis
	let transitionStyle: PopupDialogTransitionStyle
	let gestureDismissal: Bool
	let panGestureDismissal: Bool
	let doneButton: AlertButton?
	
	init(title: String? = nil,
		 message: String,
		 buttonAlignment: NSLayoutConstraint.Axis = .horizontal,
		 transitionStyle: PopupDialogTransitionStyle = .zoomIn,
		 gestureDismissal: Bool = true,
		 panGestureDismissal: Bool = true,
		 doneButton: AlertButton? = .normal) {
		self.title = title
		self.message = message
		self.buttonAlignment = buttonAlignment
		self.transitionStyle = transitionStyle
		self.gestureDismissal = gestureDismissal
		self.panGestureDismissal = panGestureDismissal
		self.doneButton = doneButton
	}
}

protocol AlertServiceProtocol {
	func show(_ input: AlertInput) -> Observable<Void>
	func forceDismiss()
}
