//
//  BasicInforProfileVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

struct BasicInforProfileData {
	let userName: String
	let email: String
	let password: String
	let firstName: String
	let lastName: String
	let isAgreeTermOfUse: Bool
}

class BasicInforProfileVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var userNameTextField: UITextField!
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
	@IBOutlet private weak var firstNameTextField: UITextField!
	@IBOutlet private weak var lastNameTextField: UITextField!
	
	@IBOutlet private weak var termOfUseTextView: UITextView!
	@IBOutlet private weak var termOfUseButton: UIButton!
	private var isAgreeTermOfUse: Bool = true {
		didSet {
			termOfUseButton.setImage((isAgreeTermOfUse) ? #imageLiteral(resourceName: "ic_checked") : #imageLiteral(resourceName: "ic_unchecked"), for: .normal)
		}
	}
	
	@IBOutlet private weak var lblNote: UILabel!
	
	private let pBasicInforProfile = PublishSubject<BasicInforProfileData>()
	private let pTermOfUseDidTap = PublishSubject<TermOfUseViewType>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforProfileVC {
	var basicInforProfile: Observable<BasicInforProfileData> {
		return pBasicInforProfile
	}
	
	var termOfUseDidTap: Observable<TermOfUseViewType> {
		return pTermOfUseDidTap
	}
	
	func selected(profile: BasicInforProfileData) {
		userNameTextField.text = profile.userName
		emailTextField.text = profile.email
		firstNameTextField.text = profile.firstName
		lastNameTextField.text = profile.lastName
		isAgreeTermOfUse = profile.isAgreeTermOfUse
	}
	
	func configForUpdating() {
		userNameTextField.isEnabled = false
		emailTextField.isEnabled = false
		passwordTextField.isEnabled = false
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforProfileVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.createAccountTextTitle()
		
		setUpTermOfUse()
		
		lblNote.text = LocalizedString.noteCreateAccountTitle()
		//		nextButton.setTitle(LocalizedString.nextButtonTitle(), for: .normal)
		
	}
	
	func subcribeSetup() {
		let validation = { (previous: String?, new: String) -> String in
			if new.count > 10 {
				return previous ?? ""
			}
			
			return new
		}
		
		// Validate Input Lenght
		firstNameTextField.rx
			.text
			.orEmpty
			.scan("", accumulator: validation)
			.subscribe(firstNameTextField.rx.text)
			.disposed(by: disposeBag)
		
		lastNameTextField.rx
			.text
			.orEmpty
			.scan("", accumulator: validation)
			.subscribe(lastNameTextField.rx.text)
			.disposed(by: disposeBag)
		
		// termOfUse button click
		termOfUseButton.rx
			.tapGesture()
			.when(.recognized)
			.subscribe(onNext: { [weak self] _ in
				self?.changeTermStatus()
			})
			.disposed(by: disposeBag)
		
		// Combine and notify value
		let userName = userNameTextField.rx
			.text
			.orEmpty
		let email = emailTextField.rx
			.text
			.orEmpty
		let password = passwordTextField.rx
			.text
			.orEmpty
		let firstName = firstNameTextField.rx
			.text
			.orEmpty
		let lastName = lastNameTextField.rx
			.text
			.orEmpty
		
		let combineResult = { [weak self] (userName: String, email: String, password: String, firstName: String, lastName: String) -> BasicInforProfileData in
			let isAgree = self?.isAgreeTermOfUse ?? false
			
			return BasicInforProfileData(userName: userName,
										 email: email,
										 password: password,
										 firstName: firstName,
										 lastName: lastName,
										 isAgreeTermOfUse: isAgree)
		}
		
		return Observable
			.combineLatest(userName, email, password, firstName, lastName)
			.map(combineResult)
			.bind(to: pBasicInforProfile)
			.disposed(by: disposeBag)
	}
	
	func changeTermStatus() {
		isAgreeTermOfUse = !isAgreeTermOfUse
	}
	
	func setUpTermOfUse() {
		let policyString = LocalizedString.localizedString(input: "Title_Policy")
		let termString = LocalizedString.localizedString(input: "Title_Terms")
		let string = String(format: LocalizedString.titleAgreeTermOfUse(), policyString, termString)
		
		let policyIndex = string.distance(from: string.startIndex, to:(string.range(of: policyString)!.lowerBound))
		let termIndex = string.distance(from: string.startIndex, to:(string.range(of: termString)!.lowerBound))
		
		let policyRange = NSRange(location: policyIndex, length: policyString.count)
		let termRange = NSRange(location: termIndex, length: termString.count)
		let stringRange = NSRange(location: 0, length: string.utf16.count)
		
		let attributedString = NSMutableAttributedString(string: string)
		attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 12), range: stringRange)
		attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: stringRange)
		
		attributedString.addAttribute(.link, value: policyString, range: policyRange)
		attributedString.addAttribute(.link, value: termString, range: termRange)
		
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: policyRange)
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termRange)
		
		termOfUseTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		termOfUseTextView.attributedText = attributedString
		termOfUseTextView.isEditable = false
		termOfUseTextView.isSelectable = true
		termOfUseTextView.delegate = self
	}
}

extension BasicInforProfileVC: UITextViewDelegate {
	@available(iOS 10.0, *)
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		if URL.absoluteString == "policy" {
			pTermOfUseDidTap.onNext(.policy)
		} else {
			pTermOfUseDidTap.onNext(.termOfUse)
		}
		
		return false
	}
}
