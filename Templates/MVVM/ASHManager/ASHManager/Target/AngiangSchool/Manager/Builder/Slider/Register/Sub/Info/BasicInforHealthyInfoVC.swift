//
//  BasicInforHealthyInfoVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BasicInforHealthyInfoVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private var feelConditionLabels: [GKBodyLabel]!
	@IBOutlet private var feelConditionButtons: [UIButton]!
	
	private let pFeelCondition = PublishSubject<FeelCondition>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforHealthyInfoVC {
	var feelCondition: Observable<FeelCondition> {
		return pFeelCondition
	}
	
	func selected(feelCondition: FeelCondition) {
		return select(feelCondition: feelCondition, needNoti: false)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforHealthyInfoVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.healthTextQuestionTitle()
		
		let sources: [FeelCondition] = [.verygood, .good, .bad, .verybad]
		let number = feelConditionButtons.count
		
		for i in 0..<number {
			let button = feelConditionButtons[i]
			let label = feelConditionLabels[i]
			
			let source = sources[i]
			button.tag = source.rawValue
			label.text = source.desc()
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let feelCondition = FeelCondition(rawValue: tag) else {
					return
				}
				
				instance.select(feelCondition: feelCondition, needNoti: true)
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
	
	func select(feelCondition: FeelCondition, needNoti: Bool) {
		for button in feelConditionButtons {
			let icon = (button.tag != feelCondition.rawValue) ? "ic_checked" : "ic_unchecked"
			let image = UIImage(named: icon)
			
			button.setImage(image, for: .normal)
		}
		
		if needNoti {
			pFeelCondition.onNext(feelCondition)
		}
	}
}

//class BasicInforHealthyInfoVC: AbstractBasicInforVC {
//	// MARK: - ================================= Properties =================================
//	private let checkBoxImage: UIImage = UIImage(named: "ic_checked")!
//	private let uncheckBoxImage: UIImage = UIImage(named: "ic_unchecked")!
//	@IBOutlet private var feelConditions: [UIButton]!
//	@IBOutlet weak var veryGoodButton: UIButton!
//	@IBOutlet weak var goodButton: UIButton!
//	@IBOutlet weak var badButton: UIButton!
//	@IBOutlet weak var veryBadButton: UIButton!
//	@IBOutlet weak var lblTitle: GKHeaderLabel!
//
//	@IBOutlet weak var lblVeryGood: GKBodyLabel!
//	@IBOutlet weak var lblGood: GKBodyLabel!
//	@IBOutlet weak var lblBad: GKBodyLabel!
//	@IBOutlet weak var lblVeryBad: GKBodyLabel!
//
//
//	let feelCondition: PublishSubject<FeelCondition> = PublishSubject<FeelCondition>()
//
//	// MARK: - ================================= Action =================================
//
//	override func awakeFromNib() {
//		super.awakeFromNib()
//
//		lblTitle.text = LocalizedString.healthTextQuestionTitle()
//		lblVeryGood.text = LocalizedString.healthCheckbox1Title()
//		lblGood.text = LocalizedString.healthCheckbox2Title()
//		lblBad.text = LocalizedString.healthCheckbox3Title()
//		lblVeryBad.text = LocalizedString.healthCheckbox4Title()
//
//	}
//
//	func configFeelCondition(_ feelCondition: FeelCondition?) {
//		let feelCondition = feelCondition ?? .other
//
//		switch feelCondition {
//		case .other:
//			break
//		case .bad:
//			changeStatusCheckbox(buttonTaped: badButton, listButton: feelConditions)
//		case .good:
//			changeStatusCheckbox(buttonTaped: goodButton, listButton: feelConditions)
//		case .verybad:
//			changeStatusCheckbox(buttonTaped: veryBadButton, listButton: feelConditions)
//		case .verygood:
//			changeStatusCheckbox(buttonTaped: veryGoodButton, listButton: feelConditions)
//		}
//	}
//
//	@IBAction func checkFeelConditionVeryGood(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: feelConditions)
//		feelCondition.onNext(.verygood)
//	}
//
//	@IBAction func checkFeelConditionGood(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: feelConditions)
//		feelCondition.onNext(.good)
//	}
//
//	@IBAction func checkFeelConditionBad(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: feelConditions)
//		feelCondition.onNext(.bad)
//	}
//
//	@IBAction func checkFeelConditionVeryBad(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: feelConditions)
//		feelCondition.onNext(.verybad)
//	}
//
//	private func changeStatusCheckbox(buttonTaped: UIButton, listButton: [UIButton]) {
//		for button in listButton {
//			if (button == buttonTaped) {
//				button.setImage(checkBoxImage , for: .normal)
//				continue
//			}
//
//			button.setImage(uncheckBoxImage , for: .normal)
//		}
//	}
//}
//
//extension BasicInforHealthyInfoVC: PresentTextFieldDataSource {
//	func dataPresentProvider() -> [PresentItem] {
//		return [PresentItem(title: FeelCondition.verygood.desc(), value: FeelCondition.verygood),
//				PresentItem(title: FeelCondition.good.desc(), value: FeelCondition.good),
//				PresentItem(title: FeelCondition.bad.desc(), value: FeelCondition.bad),
//				PresentItem(title: FeelCondition.verybad.desc(), value: FeelCondition.verybad)]
//	}
//}
