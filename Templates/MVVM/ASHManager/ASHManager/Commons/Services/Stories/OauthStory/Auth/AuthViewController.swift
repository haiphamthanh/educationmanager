//
//  AuthViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/1/17. d
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import FBSDKLoginKit
import GoogleSignIn

class AuthViewController: ViewControllerAdapter {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
	@IBOutlet private weak var loginButton: UIButton!
	
	@IBOutlet private weak var facebookButton: UIButton!
	@IBOutlet private weak var googleButton: UIButton!
	@IBOutlet private weak var forgotPassButton: UIButton!
	
	@IBOutlet private weak var termsCheckboxButton: CheckBoxButton!
	@IBOutlet private weak var termOfUseTextView: TermOfUseTextView!
	
	private let policyLink = "policy"
	private let termLink = "term"
	
	// MARK: - ================================= Init =================================
	override func setupViews() {
		super.setupViews()
		
		loginButton.setTitle(LocalizedString.titleLogin(), for: .normal)
		facebookButton.setTitle(LocalizedString.titleFacebookLogin(), for: .normal)
		googleButton.setTitle(LocalizedString.titleGoogleLogin(), for: .normal)
		forgotPassButton.setTitle(LocalizedString.titleForgotPassword(), for: .normal)
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
		let accountSignIn = strongify(self, closure: { (instance, _: Void) in
			return instance.signInByAccount()
		})
		loginButton.rx
			.tap
			.bind(onNext: accountSignIn)
			.disposed(by: disposeBag)
		
		let facebookSignIn = strongify(self, closure: { (instance, _: Void) in
			return instance.signInByFacebook()
		})
		facebookButton.rx
			.tap
			.bind(onNext: facebookSignIn)
			.disposed(by: disposeBag)
		
		let googleSignIn = strongify(self, closure: { (instance, _: Void) in
			return instance.signInByGoogle()
		})
		googleButton.rx
			.tap
			.bind(onNext: googleSignIn)
			.disposed(by: disposeBag)
		
		let selectedTerm = strongify(self, closure: { (instance, term: TermLink) in
			return instance.access(term: term)
		})
		termOfUseTextView.didSelect
			.bind(onNext: selectedTerm)
			.disposed(by: disposeBag)
		
		forgotPassButton.rx
			.tap
			.bind(to: viewModel.forgotPassword)
			.disposed(by: disposeBag)
		
		let emailInput = emailTextField.rx
			.text
			.orEmpty
		let passwordInput = emailTextField.rx
			.text
			.orEmpty
		let checkboxInput = termsCheckboxButton.status
		Observable
			.combineLatest(emailInput, passwordInput, checkboxInput)
			.map({ (userName: $0, pass: $1, isAgreeTerm: $2) })
			.bind(to: viewModel.input)
			.disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.titleLogin()
	}
	
	override func configView(with dataSource: Any) {
		if let dataSource = dataSource as? AuthViewData {
			termsCheckboxButton.push(isAgree: dataSource.isAgreeTermOfUse)
		}
	}
}

// MARK: - ================================= Final =================================
extension AuthViewController: AuthViewProtocol {
}

// MARK: Private
private extension AuthViewController {
	var viewModel: AuthViewModelProtocol {
		return viewModelWraper(type: AuthViewModelProtocol.self)
	}
	
	func signInByAccount() {
		let param = LoginParams(param: ())
		signIn(with: param)
	}
	
	func signInByFacebook() {
		let permission = ["public_profile", "email"]
		let logInFbResult = { [weak self] (result: FBSDKLoginManagerLoginResult?, error: Error?) in
			if error != nil {
				print("Cannot login from facebook")
				return
			}
			
			guard let fb = result else {
				return
			}
			
			if fb.isCancelled {
				return
			}
			
			guard let token = fb.token.tokenString else {
				return
			}
			
			let param = LoginParams(param: FacebookParam(token: token))
			self?.signIn(with: param)
		}
		
		let loginManager = FBSDKLoginManager()
		loginManager.logOut()
		loginManager.logIn(withReadPermissions: permission, from: self, handler: logInFbResult)
	}
	
	func signInByGoogle() {
		GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
		GIDSignIn.sharedInstance().clientID = Service.shared.googleCliendId
		GIDSignIn.sharedInstance().delegate = self
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().signIn()
	}
	
	func access(term: TermLink) {
		viewModel.readTermOfUse
			.onNext(term.toTermAction())
	}
	
	func signIn<T>(with param: LoginParams<T>) {
		view.endEditing(true)
		viewModel.signIn(with: param)
	}
}

// MARK: - ======================== Social login
// MARK: Google
extension AuthViewController: GIDSignInDelegate, GIDSignInUIDelegate {
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if error != nil {
			print("\(error.localizedDescription)")
			return
		}
		
		let param = LoginParams(param: GoogleParam(user: user))
		self.signIn(with: param)
	}
	
	func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
		dismiss(animated: true, completion: nil)
	}
}

// MARK: Facebook
extension AuthViewController: FBSDKLoginButtonDelegate {
	func loginButton(_ loginButton: FBSDKLoginButton!,
					 didCompleteWith result: FBSDKLoginManagerLoginResult!,
					 error: Error!) {
		if ((error) != nil) {
		} else if result.isCancelled {
		} else { }
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
	}
}

// move later
enum TermLink: String {
	case policy = "policy"
	case term = "term"
	
	func toTermAction() -> TermAction {
		switch self {
		case .policy:
			return .policy
		case .term:
			return .termOfUse
		}
	}
}

class CheckBoxButton: UIButton {
	private let pStatus = PublishSubject<Bool>()
	private let disposeBag = DisposeBag()
	private var isChecked: Bool = false {
		didSet {
			let name = isChecked ? "ic_textbox_checked" : "ic_textbox_unchecked"
			guard let image = UIImage(named: name) else {
				return
			}
			
			setImage(image, for: .normal)
			pStatus.onNext(isChecked)
		}
	}
}

extension CheckBoxButton {
	var status: Observable<Bool> {
		return pStatus
	}
	
	func push(isAgree: Bool = false) {
		isChecked = isAgree
		
		let tapAction = strongify(self, closure: { (instance, _: Void) in
			return instance.changeState()
		})
		rx.tap
			.bind(onNext: tapAction)
			.disposed(by: disposeBag)
	}
}

private extension CheckBoxButton {
	func changeState() {
		isChecked = !isChecked
	}
}

class TermOfUseTextView: UITextView {
	let didSelect = PublishSubject<TermLink>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let policyString = LocalizedString.localizedString(input: "Title_Policy")
		let termString = LocalizedString.localizedString(input: "Title_Terms")
		let string = String(format: LocalizedString.titleAgreeTermOfUse(), policyString, termString)
		
		let policyIndex = string.distance(from: string.startIndex, to:(string.range(of: policyString)!.lowerBound))
		let termIndex = string.distance(from: string.startIndex, to:(string.range(of: termString)!.lowerBound))
		
		let policyLinkAttributes = [
			NSAttributedString.Key.link: URL(string: TermLink.policy.rawValue)!,
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
			NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
			NSAttributedString.Key.foregroundColor: UIColor.black
			] as [NSAttributedString.Key : Any]
		
		let termLinkAttributes = [
			NSAttributedString.Key.link: URL(string: TermLink.term.rawValue)!,
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
			NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
			NSAttributedString.Key.foregroundColor: UIColor.black
			] as [NSAttributedString.Key : Any]
		
		let attributedString = NSMutableAttributedString(string: string)
		attributedString.setAttributes(policyLinkAttributes, range: NSRange(location: policyIndex, length: policyString.count))
		attributedString.setAttributes(termLinkAttributes, range: NSRange(location: termIndex, length: termString.count))
		attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: string.utf16.count))
		attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: string.utf16.count))
		
		attributedText = attributedString
		isEditable = false
		isSelectable = true
		delegate = self
	}
}

extension TermOfUseTextView: UITextViewDelegate {
	@available(iOS 10.0, *)
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		guard let termLink = TermLink(rawValue: URL.absoluteString) else {
			return true
		}
		
		didSelect.onNext(termLink)
		return false
	}
}
