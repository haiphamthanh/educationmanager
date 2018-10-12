//
//  BasicInforSurgeryVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/29/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforSurgeryVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private var surgeryLabels: [GKBodyLabel]!
	@IBOutlet private var surgeryButtons: [UIButton]!
	
	private let pSurgery = PublishSubject<Surgery>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforSurgeryVC {
	var surgery: Observable<Surgery> {
		return pSurgery
	}
	
	func selected(surgery: Surgery) {
		return select(surgery: surgery, needNoti: false)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforSurgeryVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.surgeryTextQuestionTitle()
		
		let sources: [Surgery] = [.yes, .no]
		let number = surgeryButtons.count
		
		for i in 0..<number {
			let button = surgeryButtons[i]
			let label = surgeryLabels[i]
			
			let source = sources[i]
			button.tag = source.rawValue
			label.text = source.desc()
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let surgery = Surgery(rawValue: tag) else {
					return
				}
				
				instance.select(surgery: surgery, needNoti: true)
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
	
	func select(surgery: Surgery, needNoti: Bool) {
		for button in surgeryButtons {
			let icon = (button.tag != surgery.rawValue) ? "ic_checked" : "ic_unchecked"
			let image = UIImage(named: icon)
			
			button.setImage(image, for: .normal)
		}
		
		if needNoti {
			pSurgery.onNext(surgery)
		}
	}
}
