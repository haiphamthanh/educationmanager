//
//  BasicInforHeightVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BasicInforHeightVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var heightTextField: UITextField!
	
	private let maxHeight: Double = 300
	private let pHeight = PublishSubject<Double>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforHeightVC {
	var height: Observable<Double> {
		return pHeight
	}
	
	func selected(height: Double) {
		return heightTextField.text = "\(height)"
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforHeightVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.heightTitle()
	}
	
	func subcribeSetup() {
		// Validate Input Float
		heightTextField.rx
			.text
			.orEmpty
			.scan("") { [weak self] (previous, new) -> String in
				guard let strongSelf = self, !new.isEmpty else {
					return "1"
				}
				
				guard let newValue = Double(new) else {
					return previous!
				}
				
				return newValue < strongSelf.maxHeight ? new : "\(strongSelf.maxHeight)"
			}
			.subscribe(heightTextField.rx.text)
			.disposed(by: disposeBag)
		
		// Notify value
		return heightTextField.rx
			.text
			.map({ Double($0!)! })
			.bind(to: pHeight)
			.disposed(by: disposeBag)
	}
}
