//
//  BasicInforTabacoVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforTabacoVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private var frequencyLabels: [GKBodyLabel]!
	@IBOutlet private var frequencyButtons: [UIButton]!
	
	private let pTabaco = PublishSubject<(level: SmokingLevel, frequency: SmokingFrequency)>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforTabacoVC {
	var tabaco: Observable<(level: SmokingLevel, frequency: SmokingFrequency)> {
		return pTabaco
	}
	
	func selected(tabaco: (level: SmokingLevel, frequency: SmokingFrequency)) {
		return select(tabaco: tabaco, needNoti: false)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforTabacoVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.drinkTextQuestionTitle()
		
		let sources: [SmokingFrequency] = [.noway, .whenDrinking, .everyday]
		let number = frequencyButtons.count
		
		for i in 0..<number {
			let button = frequencyButtons[i]
			let label = frequencyLabels[i]
			
			let source = sources[i]
			button.tag = source.rawValue
			label.text = source.desc()
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let frequency = SmokingFrequency(rawValue: tag) else {
					return
				}
				
				//				instance.select(frequency: frequency, needNoti: true)
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
	
	func select(tabaco: (level: SmokingLevel, frequency: SmokingFrequency), needNoti: Bool) {
		for button in frequencyButtons {
			let icon = (button.tag != tabaco.frequency.rawValue) ? "ic_checked" : "ic_unchecked"
			let image = UIImage(named: icon)
			
			button.setImage(image, for: .normal)
		}
		
		if needNoti {
			pTabaco.onNext(tabaco)
		}
	}
}

//// TODO: HaiPT15 - Create Detail popup
//class BasicInforTabacoVC: AbstractBasicInforVC {
//	// MARK: - ================================= Properties =================================
//	fileprivate let checkBoxImage: UIImage = UIImage(named: "ic_checked")!
//	fileprivate let uncheckBoxImage: UIImage = UIImage(named: "ic_unchecked")!
//	@IBOutlet private var frequencies: [UIButton]!
//	@IBOutlet private var listText: [UILabel]!
//	@IBOutlet private var titleLabel: UILabel!
//
//	@IBOutlet weak var nowayButton: UIButton!
//	@IBOutlet weak var sometimeButton: UIButton!
//	@IBOutlet weak var normalButton: UIButton!
//
//	@IBOutlet weak var secondText: UILabel!
//	@IBOutlet weak var thirdText: UILabel!
//	@IBOutlet weak var lblLevel1: GKBodyLabel!
//	@IBOutlet weak var lblLevel2: GKBodyLabel!
//	@IBOutlet weak var lblLevel3: GKBodyLabel!
//
//	let smokingEachTime: PublishSubject<SmokingLevel> = PublishSubject<SmokingLevel>()
//	let frequency: PublishSubject<SmokingFrequency> = PublishSubject<SmokingFrequency>()
//	var frequencyDetail: Int?
//
//	override func awakeFromNib() {
//		super.awakeFromNib()
//
//		setupViews()
//	}
//
//	private func enable(_ text: UILabel, _ enable: Bool) {
//		text.alpha = enable ? 1 : 0
//	}
//
//	private func resetAll() {
//		for text in listText {
//			enable(text, false)
//		}
//	}
//
//	private func setupViews() {
//		secondText.setupFont(textColor: .white)
//		thirdText.setupFont(textColor: .white)
//
//		enable(secondText, false)
//		enable(thirdText, false)
//
//		titleLabel.text = LocalizedString.smokeTextQuestionTitle()
//		lblLevel1.text = LocalizedString.smokeCheckbox1Title()
//		lblLevel2.text = LocalizedString.smokeCheckbox2Title()
//		lblLevel3.text = LocalizedString.smokeCheckbox3Title()
//	}
//
//	// MARK: - ================================= Action =================================
//	func configFrequency(_ frequency: SmokingFrequency?) {
//		let frequency = frequency ?? .other
//
//		var currentCheckedTobaccoDetailLbl = UILabel()
//		switch frequency {
//		case .other:
//			break
//		case .noway:
//			changeStatusCheckbox(buttonTaped: nowayButton, listButton: frequencies)
//		case .whenDrinking:
//			changeStatusCheckbox(buttonTaped: sometimeButton, listButton: frequencies)
//			currentCheckedTobaccoDetailLbl = secondText
//		case .everyday:
//			changeStatusCheckbox(buttonTaped: normalButton, listButton: frequencies)
//			currentCheckedTobaccoDetailLbl = thirdText
//		}
//
//		if let frequencyDetailIndex = self.frequencyDetail, let subText = SmokingLevel(rawValue: frequencyDetailIndex)?.desc() {
//			currentCheckedTobaccoDetailLbl.text = "(" + subText + ")"
//		}
//	}
//
//	@IBAction func checkedFrequencyNoway(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.noway)
//	}
//
//	@IBAction func checkedFrequencySomeTime(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.whenDrinking)
//
//		showPopup(text: secondText)
//	}
//
//	@IBAction func checkedFrequencyNormal(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.everyday)
//
//		showPopup(text: thirdText)
//	}
//
//	private func showPopup(text: UILabel) {
//		//TODO: HaiPT15
//		//		let tabaccoPopupVC = TabaccoPopupViewController()
//		//
//		//		let okAction = {
//		//			if let subText = SmokingLevel(rawValue: tabaccoPopupVC.buttonChecked.tag)?.desc() {
//		//				text.text = "(" + subText + ")"
//		//			} else {
//		//				if let textdesc = SmokingLevel(rawValue: 1)?.desc() {
//		//					text.text = "(" + textdesc + ")"
//		//				}
//		//			}
//		//
//		//			if let smokingLevelDetailIndex = SmokingLevel(rawValue: tabaccoPopupVC.buttonChecked.tag) {
//		//				self.smokingEachTime.onNext(smokingLevelDetailIndex)
//		//			} else {
//		//				self.smokingEachTime.onNext(SmokingLevel.lessThanTen)
//		//			}
//		//		}
//		//
//		//		//Get Text On Label
//		//		if var text = text.text {
//		//			text.removeFirst()
//		//			text.removeLast()
//		//			tabaccoPopupVC.currentIndex = SmokingLevel(name: text).rawValue
//		//		}
//		//
//		//		//------------------- show popup ------------------
//		//		let popup = GKPopup.showPopup(withVC: tabaccoPopupVC,
//		//									  arrButton: [PopupStruct(title: "OK", action: okAction)])
//		//
//		//		viewController()?.present(popup, animated: true, completion: nil)
//	}
//
//	private func changeStatusCheckbox(buttonTaped: UIButton, listButton: [UIButton]) {
//		for button in listButton {
//			if (button == buttonTaped) {
//				button.setImage(checkBoxImage , for: .normal)
//				checkEnable(index: button.tag)
//				continue
//			}
//
//			button.setImage(uncheckBoxImage , for: .normal)
//		}
//	}
//
//	private func checkEnable(index: Int) {
//		if index == 1 {
//			resetAll()
//			return
//		}
//
//		for text in listText {
//			if (text.tag == index) {
//				enable(text, true)
//				continue
//			}
//
//			enable(text, false)
//		}
//	}
//}
//
//extension BasicInforTabacoVC: PresentTextFieldDataSource {
//	func dataPresentProvider() -> [PresentItem] {
//		return [PresentItem(title: SmokingFrequency.noway.desc(), value: SmokingFrequency.noway),
//				PresentItem(title: SmokingFrequency.whenDrinking.desc(), value: SmokingFrequency.whenDrinking),
//				PresentItem(title: SmokingFrequency.everyday.desc(), value: SmokingFrequency.everyday)]
//	}
//}
