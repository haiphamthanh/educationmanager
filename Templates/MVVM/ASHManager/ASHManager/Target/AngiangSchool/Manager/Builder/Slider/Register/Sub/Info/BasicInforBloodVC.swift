//
//  BasicInforBloodVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforBloodVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private weak var bloodTypeTextField: GKPresentTextField!
	
	private let pBloodType = PublishSubject<BloodType>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforBloodVC {
	var bloodType: Observable<BloodType> {
		return pBloodType
	}
	
	func selected(bloodType: BloodType) {
		return bloodTypeTextField.selectVlue(value: bloodType)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforBloodVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.bloodTypeTitle()
		
		bloodTypeTextField.presentDataSource = self
		bloodTypeTextField.presentDelegate = self
	}
	
	func subcribeSetup() {
	}
}

extension BasicInforBloodVC: PresentTextFieldDataSource {
	func dataPresentProvider() -> [PresentItem] {
		return [PresentItem(title: BloodType.a.desc(), value: BloodType.a),
				PresentItem(title: BloodType.b.desc(), value: BloodType.b),
				PresentItem(title: BloodType.ab.desc(), value: BloodType.ab),
				PresentItem(title: BloodType.o.desc(), value: BloodType.o)]
	}
}

extension BasicInforBloodVC: PresentTextFieldDelegate {
	func presentTextField(textField: PresentTextField, didSelected item: PresentItem) {
		guard let blood = item.value as? BloodType else { return }
		pBloodType.onNext(blood)
	}
}
