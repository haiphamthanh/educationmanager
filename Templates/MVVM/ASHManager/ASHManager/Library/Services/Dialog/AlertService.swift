//
//  BasePageDialogService.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/7/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import PopupDialog

class AlertService {
	// MARK: - ================================= Properties =================================
	private let pDone = PublishSubject<Void>()
	private let navigationService: BasicNavigationServiceProtocol
	
	// MARK: - ================================= Init =================================
	init(navigationService: BasicNavigationServiceProtocol) {
		self.navigationService = navigationService
	}
	
	deinit {
		print("\(self) deinit")
	}
}

// MARK: - ================================= Public actions =================================
extension AlertService: AlertServiceProtocol {
	func show(_ input: AlertInput) -> Observable<Void> {
		let title = input.title
		let message = input.message
		let buttonAlignment = input.buttonAlignment
		let transitionStyle = input.transitionStyle
		let gestureDismissal = input.gestureDismissal
		let panGestureDismissal = input.panGestureDismissal
		let doneButton = (input.doneButton ?? .normal)
			.button(title: LocalizedString.localizedString(input: "Keyboard.Button.OK"))
		
		let popup = PopupDialog(title: title,
								message: message,
								buttonAlignment: buttonAlignment,
								transitionStyle: transitionStyle,
								preferredWidth: 100,
								tapGestureDismissal: gestureDismissal,
								panGestureDismissal: panGestureDismissal,
								hideStatusBar: true) { [weak self] in
									self?.didDismiss()
		}
		popup.addButton(doneButton)
		
		// Present dialog
		navigationService.present(viewController: popup, animated: true, completion: nil)
		return pDone.asObserver()
	}
	
	func forceDismiss() {
		navigationService.dismiss(animated: true) { [weak self] in
			self?.didDismiss()
		}
	}
}

private extension AlertService {
	func didDismiss() {
		pDone.onNext(())
	}
}
