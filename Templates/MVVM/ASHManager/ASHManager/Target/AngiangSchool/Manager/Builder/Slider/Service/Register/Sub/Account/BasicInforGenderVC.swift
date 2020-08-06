//
//  BasicInforGenderVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import RxGesture

class BasicInforGenderVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private var genderLabels: [UILabel]!
	@IBOutlet private var genderButtons: [UIButton]!
	
	private let pGender = PublishSubject<GenderType>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforGenderVC {
	var gender: Observable<GenderType> {
		return pGender
	}
	
	func selected(gender: GenderType) {
		select(gender: gender, needNoti: false)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforGenderVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.genderTitle()
		
		let sources: [GenderType] = [.male, .female]
		let number = genderButtons.count
		
		for i in 0..<number {
			let source = sources[i]
			guard let desc = source.desc() else {
				continue
			}
			
			let button = genderButtons[i]
			let label = genderLabels[i]
			
			button.backgroundColor = .clear
			button.tag = source.rawValue
			
			if let image = UIImage(named: desc.unSelectedIcon) {
				button.setImage(image, for: .normal)
			}
			
			label.text = desc.name
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let gender = GenderType(rawValue: tag) else {
					return
				}
				
				instance.select(gender: gender, needNoti: true)
			})
			
			button.rx
				.tapGesture()
				.when(.recognized)
				.subscribe(onNext: success)
				.disposed(by: disposeBag)
		}
	}
	
	func subcribeSetup() {
	}
	
	func select(gender: GenderType, needNoti: Bool) {
		for button in genderButtons {
			guard let desc = gender.desc() else { continue }
			
			let icon = (button.tag != gender.rawValue) ? desc.selectedIcon : desc.unSelectedIcon
			let image = UIImage(named: icon)
			
			button.setImage(image, for: .normal)
		}
		
		if needNoti {
			pGender.onNext(gender)
		}
	}
}
