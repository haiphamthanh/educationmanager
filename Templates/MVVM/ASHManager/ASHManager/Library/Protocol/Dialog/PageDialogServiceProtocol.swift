//
//  PageDialogServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/2/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import PopupDialog

// MARK: - ================================= Config view =================================
enum PopUpViewControllerType: Int {
	case userProfile = 0
	case weight
	case water
	case cafein
	case alcohol
	case tabacco
	case device
	case step
	case foodAdding
	case password
	case sharing
	case join
	case healthChecking
	case message
	case photoSelection
	case inviteCode
	case gobe
	
	func vc(params: Dictionary<String, Any>?) -> AbstractPopUpViewController? {
		switch self {
		case .userProfile:
			return nil //UserProfilePopUpViewController
		case .weight:
			return nil //WeightPopUpViewController
		case .water:
			return nil //WaterPopUpViewController
		case .cafein:
			return nil //CafeinPopUpViewController
		case .alcohol:
			return nil //AlcoholPopUpViewController
		case .tabacco:
			return nil //TabaccoPopupViewController
		case .device:
			return nil //DeviceProfilePopupViewController
		case .step:
			return nil //StepPopUpViewController
		case .foodAdding:
			return nil //FoodAddingPopUpViewController
		case .password:
			return nil //PasswordPopupViewController
		case .sharing:
			return nil //SharePopupViewController
		case .join:
			return nil //InputJoinProgramPopupViewController
		case .healthChecking:
			return nil //BaseHealthCheckPopupViewController
		case .message:
			return nil //MessagePopupViewController
		case .photoSelection:
			return nil //PhotoPopupViewController
		case .inviteCode:
			return nil //InviteCodePopupViewController
		case .gobe:
			return nil //GobePopupViewController
		}
	}
}

protocol PopUpInputProtocol {
	
}

protocol PopUpOutputProtocol {
	
}

class AbstractPopUpInput: PopUpInputProtocol {
	
}

class AbstractPopUpOutput: PopUpOutputProtocol {
	
}

class InvitePopUpOutput: AbstractPopUpOutput {
	let code: String
	required init(code: String) {
		self.code = code
	}
}

class GobePopUpOutput: AbstractPopUpOutput {
	let userName: String
	let password: String
	required init(userName: String, password: String) {
		self.userName = userName
		self.password = password
	}
}

class AbstractPopUpViewController: UIViewController {
	func ok() {
		fatalError("Implement in subclass")
	}
}

class BasePopUpViewController<I: PopUpInputProtocol, O: PopUpOutputProtocol>: AbstractPopUpViewController {
	typealias PopupDialogAction = (O) -> Void
	private var viewAction: PopupDialogAction?
	private var data: I?
	
	// MARK: - ================================= Action =================================
	/// Call for callback ok action
	///
	final func push(data: I? = nil,
					action: @escaping PopupDialogAction) {
		self.data = data
		self.viewAction = action
		
		configView(data: data)
	}
	
	/// Call for callback ok action
	///
	final override func ok() {
		let success = strongify(self, closure: { (instance, _: Void) in
			guard let data = instance.actionData() else {
				return
			}
			
			instance.viewAction?(data)
		})
		
		dismiss(animated: true, completion: success)
	}
	
	// MARK: - ================================= Customize =================================
	/// Config view for input data
	///
	func configView(data: I?) {
	}
	
	/// Data for callback ok action
	///
	/// - Returns: Any data, nil if not need anymore
	func actionData() -> O? {
		fatalError("Implement in subclass")
	}
}

struct PageDialogButton {
	let type: DialogButtonType?
	let title: String
	let titleColor: UIColor?
	let bgColor: UIColor?
	let fontSize: CGFloat?
	let action: (() -> Void)?
	
	init(type: DialogButtonType? = .normal,
		 title: String,
		 titleColor: UIColor? = .white,
		 bgColor: UIColor? = UIColor("#FD9426"),
		 fontSize: CGFloat? = 13,
		 action: (() -> Void)? = nil) {
		self.type = type
		self.title = title
		self.titleColor = titleColor
		self.bgColor = bgColor
		self.fontSize = fontSize
		self.action = action
	}
}

struct PageDialogMessage {
	let title: String?
	let message: String
	let buttons: [PageDialogButton]?
	
	init(title: String? = nil, message: String, buttons: [PageDialogButton]? = [PageDialogButton(title: LocalizedString.localizedString(input: "Keyboard.Button.OK"))]) {
		self.title = title
		self.message = message
		self.buttons = buttons
	}
}

struct PageDialogActionMessage<O: PopUpOutputProtocol> {
	let type: PopUpViewControllerType
	let params: Dictionary<String, Any>?
	let title: String?
	let message: String?
	let confirmButtons: Bool
	let action: ((O) -> ())?
	
	init(type: PopUpViewControllerType,
		 params: Dictionary<String, Any>? = nil,
		 title: String? = nil,
		 message: String? = nil,
		 confirmButtons: Bool = true,
		 action: ((O) -> ())? = nil) {
		self.type = type
		self.params = params
		self.title = title
		self.message = message
		self.confirmButtons = confirmButtons
		self.action = action
	}
}

protocol PageDialogServiceProtocol {
	// MARK: - ================================= Init =================================
	func use(navigationService: BasicNavigationServiceProtocol)
	
	// MARK: - ================================= Usage =================================
	/// <#Description#>
	///
	/// - Parameters:
	///   - message: <#message description#>
	///   - cancelTitle: <#cancelTitle description#>
	///   - action: <#action description#>
	/// - Returns: <#return value description#>
	func show(message: PageDialogMessage)
	
	/// <#Description#>
	///
	/// - Parameters:
	///   - viewController: <#viewController description#>
	///   - buttonAlignment: <#buttonAlignment description#>
	///   - transitionStyle: <#transitionStyle description#>
	///   - preferredWidth: <#preferredWidth description#>
	///   - gestureDismissal: <#gestureDismissal description#>
	/// - Returns: <#return value description#>
	func show(vcType: PopUpViewControllerType,
			  params: Dictionary<String, Any>?,
			  buttonAlignment: UILayoutConstraintAxis,
			  transitionStyle: PopupDialogTransitionStyle,
			  preferredWidth: CGFloat?,
			  gestureDismissal: Bool,
			  confirmButtons: Bool)
	func show(vcType: PopUpViewControllerType,
			  params: Dictionary<String, Any>?,
			  confirmButtons: Bool)
	
	/// <#Description#>
	///
	/// - Parameters:
	///   - view: <#view description#>
	///   - buttonAlignment: <#buttonAlignment description#>
	///   - transitionStyle: <#transitionStyle description#>
	///   - preferredWidth: <#preferredWidth description#>
	///   - gestureDismissal: <#gestureDismissal description#>
	/// - Returns: <#return value description#>
	func show(view: UIView,
			  buttonAlignment: UILayoutConstraintAxis,
			  transitionStyle: PopupDialogTransitionStyle,
			  preferredWidth: CGFloat?,
			  gestureDismissal: Bool)
	
	
	/// <#Description#>
	///
	/// - Parameter completion: <#completion description#>
	func dismiss(_ completion: (() -> Void)?)
	
	// TODO: To be define later =================================
	//	func show(message: PageDialogMessage, cancelButton: UIButton?, destroyButton: UIButton?, buttons: [UIButton])
	//	func show(message: PageDialogMessage, buttons: [UIButton])
	//	func show(message: PageDialogMessage, acceptButton: UIButton, cancelButton: UIButton)
	//	func show(message: PageDialogMessage, cancelButton: UIButton)
}
