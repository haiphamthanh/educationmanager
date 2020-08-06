//
//  BasicInforNickNameVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforNickNameVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var nickNameTextField: UITextField!
	
	private let pNickName = PublishSubject<String>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforNickNameVC {
	var nickName: Observable<String> {
		return pNickName
	}
	
	func selected(nickName: String) {
		nickNameTextField.text = nickName
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforNickNameVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.nicknameTextQuestionTitle()
	}
	
	func subcribeSetup() {
		// Validate Input lengh
		nickNameTextField.rx
			.text
			.orEmpty
			.scan("") { (previous, new) -> String in
				if new.count > 20 {
					return previous ?? ""
				}
				
				return new
			}
			.subscribe(nickNameTextField.rx.text)
			.disposed(by: disposeBag)
		
		// Notify value
		return nickNameTextField.rx
			.text
			.orEmpty
			.bind(to: pNickName)
			.disposed(by: disposeBag)
	}
}
