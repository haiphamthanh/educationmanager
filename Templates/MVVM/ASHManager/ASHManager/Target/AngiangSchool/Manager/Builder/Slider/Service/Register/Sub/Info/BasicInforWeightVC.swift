//
//  BasicInforWeightVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforWeightVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var weightTextField: UITextField!
	
	private let maxWeight: Double = 1000
	private let pWeight = PublishSubject<Double>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforWeightVC {
	var weight: Observable<Double> {
		return pWeight
	}
	
	func selected(height: Double) {
		weightTextField.text = "\(height)"
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforWeightVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.weightTitle()
	}
	
	func subcribeSetup() {
		// Validate Input Float
		weightTextField.rx
			.text
			.orEmpty
			.scan("") { [weak self] (previous, new) -> String in
				guard let strongSelf = self, !new.isEmpty else {
					return "1"
				}
				
				guard let newValue = Double(new) else {
					return previous!
				}
				
				return newValue < strongSelf.maxWeight ? new : "\(strongSelf.maxWeight)"
			}
			.subscribe(weightTextField.rx.text)
			.disposed(by: disposeBag)
		
		// Notify value
		return weightTextField.rx
			.text
			.map({ Double($0!)! })
			.bind(to: pWeight)
			.disposed(by: disposeBag)
	}
}
