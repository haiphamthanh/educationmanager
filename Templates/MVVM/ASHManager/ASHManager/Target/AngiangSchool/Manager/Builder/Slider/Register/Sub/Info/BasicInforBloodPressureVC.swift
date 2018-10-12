//
//  BasicInforBloodPressureVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforBloodPressureVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private weak var systolicUpTextField: UnderlineUnablePasteTextField!
	@IBOutlet private weak var diastolicDownTextField: UnderlineUnablePasteTextField!
	private let maxSystolic: Int = 999
	
	private let pBloodPresure = PublishSubject<(systolicUp: Int, diastolicDown: Int)>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforBloodPressureVC {
	var bloodPresure: Observable<(systolicUp: Int, diastolicDown: Int)> {
		return pBloodPresure
	}
	
	func selected(bloodPresure: (systolicUp: String, diastolicDown: String)) {
		systolicUpTextField.text = bloodPresure.systolicUp
		diastolicDownTextField.text = bloodPresure.diastolicDown
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforBloodPressureVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.bloodPressureTitle()
	}
	
	func subcribeSetup() {
		// Validate Input Int
		systolicUpTextField.rx
			.text
			.orEmpty
			.scan("") { [weak self] (previous, new) -> String in
				guard let strongSelf = self, !new.isEmpty else {
					return "1"
				}
				
				guard let newValue = Int(new) else {
					return previous!
				}
				
				return newValue < strongSelf.maxSystolic ? new : "\(strongSelf.maxSystolic)"
			}
			.subscribe(systolicUpTextField.rx.text)
			.disposed(by: disposeBag)
		
		// Validate Input Int
		diastolicDownTextField.rx
			.text
			.orEmpty
			.scan("") { (previous, new) -> String in
				guard !new.isEmpty else {
					return "1"
				}
				
				guard let _ = Int(new) else {
					return previous!
				}
				
				return new
			}
			.subscribe(diastolicDownTextField.rx.text)
			.disposed(by: disposeBag)
		
		// Combine and notify value
		let systolic = systolicUpTextField.rx
			.text
			.orEmpty
			.map({ $0.toInt() })
		let diastolic = diastolicDownTextField.rx
			.text
			.orEmpty
			.map({ $0.toInt() })
		
		let combineResult = { (systolicUp: Int, diastolicDown: Int) -> (systolicUp: Int, diastolicDown: Int) in
			let systolicValue = Swift.min(systolicUp, 999)
			let diastolicValue = diastolicDown
			
			return (systolicUp: systolicValue, diastolicDown: diastolicValue)
		}
		
		return Observable
			.combineLatest(systolic, diastolic)
			.map(combineResult)
			.bind(to: pBloodPresure)
			.disposed(by: disposeBag)
	}
}
