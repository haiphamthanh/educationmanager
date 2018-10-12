//
//  BasicInforAlcoholVC.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BasicInforAlcoholVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: GKHeaderLabel!
	@IBOutlet private var frequencyLabels: [GKBodyLabel]!
	@IBOutlet private var frequencyButtons: [UIButton]!
	
	private let pAlcohol = PublishSubject<(level: AlcoholLevel, frequency: AlcoholFrequency)>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforAlcoholVC {
	var alcohol: Observable<(level: AlcoholLevel, frequency: AlcoholFrequency)> {
		return pAlcohol
	}
	
	func selected(alcohol: (level: AlcoholLevel, frequency: AlcoholFrequency)) {
		return select(alcohol: alcohol, needNoti: false)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforAlcoholVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.drinkTextQuestionTitle()
		
		let sources: [AlcoholFrequency] = [.everyday, .fiveToSixTimesPerWeek, .threeToFourTimesPerWeek, .oneToTwoTimesPerWeek, .oneToThreePerMonth, .stopForMoreThanOneYear]
		let number = frequencyButtons.count
		
		for i in 0..<number {
			let button = frequencyButtons[i]
			let label = frequencyLabels[i]
			
			let source = sources[i]
			button.tag = source.rawValue
			label.text = source.desc()
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let frequency = AlcoholFrequency(rawValue: tag) else {
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
	
	func select(alcohol: (level: AlcoholLevel, frequency: AlcoholFrequency), needNoti: Bool) {
		for button in frequencyButtons {
			let icon = (button.tag != alcohol.frequency.rawValue) ? "ic_checked" : "ic_unchecked"
			let image = UIImage(named: icon)
			
			button.setImage(image, for: .normal)
		}
		
		if needNoti {
			pAlcohol.onNext(alcohol)
		}
	}
}


//// TODO: HaiPT15 - Create Detail popup
//class BasicInforAlcoholVC: AbstractBasicInforVC {
//	// MARK: - ================================= Properties =================================
//	private let checkBoxImage: UIImage = UIImage(named: "ic_checked")!
//	private let uncheckBoxImage: UIImage = UIImage(named: "ic_unchecked")!
//	@IBOutlet private var frequencies: [UIButton]!
//	@IBOutlet private var listText: [UILabel]!
//
//	@IBOutlet weak var firstText: UILabel!
//	@IBOutlet weak var secondText: UILabel!
//	@IBOutlet weak var thirdText: UILabel!
//	@IBOutlet weak var fourthText: UILabel!
//	@IBOutlet weak var fifthText: UILabel!
//
//	@IBOutlet weak var everydayButton: UIButton!
//	@IBOutlet weak var fiveToSixTimesPerWeekButton: UIButton!
//	@IBOutlet weak var threeToFourTimesPerWeekButton: UIButton!
//	@IBOutlet weak var oneToTwoTimesPerWeekButton: UIButton!
//	@IBOutlet weak var oneToThreePerMonthButton: UIButton!
//	@IBOutlet weak var stopForMoreThanOneYearButton: UIButton!
//	@IBOutlet weak var canNotDrinkButton: UIButton!
//
//	@IBOutlet weak var lblEveryDay: GKBodyLabel!
//	@IBOutlet weak var lblFiveToSix: GKBodyLabel!
//	@IBOutlet weak var lblThreeToFour: GKBodyLabel!
//	@IBOutlet weak var lblOneToTwo: GKBodyLabel!
//	@IBOutlet weak var lblOneToThree: GKBodyLabel!
//	@IBOutlet weak var lblStop: GKBodyLabel!
//	@IBOutlet weak var lblCanNot: GKBodyLabel!
//
//
//	@IBOutlet weak var lblTitle: GKHeaderLabel!
//
//
//	let frequency: BehaviorSubject<AlcoholFrequency> = BehaviorSubject<AlcoholFrequency>(value: .canNotDrink)
//	let drinkPerTime: BehaviorSubject<AlcoholLevel> = BehaviorSubject<AlcoholLevel>(value: .other)
//	var frequencyDetail: Int?
//
//	override func awakeFromNib() {
//		super.awakeFromNib()
//
//		setupViews()
//
//		lblEveryDay.text = LocalizedString.checkBox1Title()
//		lblFiveToSix.text = LocalizedString.checkBox2Title()
//		lblThreeToFour.text = LocalizedString.checkBox3Title()
//		lblOneToTwo.text = LocalizedString.checkBox4Title()
//		lblOneToThree.text = LocalizedString.checkBox5Title()
//		lblStop.text = LocalizedString.checkBox6Title()
//		lblCanNot.text = LocalizedString.checkBox7Title()
//
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
//		firstText.setupFont(textColor: UIColor.colorWithHex(AppColor.appZeroColor))
//		secondText.setupFont(textColor: UIColor.colorWithHex(AppColor.appZeroColor))
//		thirdText.setupFont(textColor: UIColor.colorWithHex(AppColor.appZeroColor))
//		fourthText.setupFont(textColor: UIColor.colorWithHex(AppColor.appZeroColor))
//		fifthText.setupFont(textColor: UIColor.colorWithHex(AppColor.appZeroColor))
//
//		enable(secondText, false)
//		enable(thirdText, false)
//		enable(fourthText, false)
//		enable(fifthText, false)
//		enable(firstText, false)
//
//	}
//
//	// MARK: - ================================= Action =================================
//	func configFrequency(_ frequency: AlcoholFrequency?) {
//		let frequency = frequency ?? .other
//
//		var currentCheckedAlcoholDetailLbl = UILabel()
//		switch frequency {
//		case .other:
//			break
//		case .everyday:
//			changeStatusCheckbox(buttonTaped: everydayButton, listButton: frequencies)
//			currentCheckedAlcoholDetailLbl = firstText
//		case .fiveToSixTimesPerWeek:
//			changeStatusCheckbox(buttonTaped: fiveToSixTimesPerWeekButton, listButton: frequencies)
//			currentCheckedAlcoholDetailLbl = secondText
//		case .threeToFourTimesPerWeek:
//			changeStatusCheckbox(buttonTaped: threeToFourTimesPerWeekButton, listButton: frequencies)
//			currentCheckedAlcoholDetailLbl = thirdText
//		case .oneToTwoTimesPerWeek:
//			changeStatusCheckbox(buttonTaped: oneToTwoTimesPerWeekButton, listButton: frequencies)
//			currentCheckedAlcoholDetailLbl = fourthText
//		case .oneToThreePerMonth:
//			changeStatusCheckbox(buttonTaped: oneToThreePerMonthButton, listButton: frequencies)
//			currentCheckedAlcoholDetailLbl = fifthText
//		case .stopForMoreThanOneYear:
//			changeStatusCheckbox(buttonTaped: stopForMoreThanOneYearButton, listButton: frequencies)
//		case .canNotDrink:
//			changeStatusCheckbox(buttonTaped: canNotDrinkButton, listButton: frequencies)
//		}
//
//		if let frequencyDetailIndex = self.frequencyDetail, let subText = AlcoholLevel(rawValue: frequencyDetailIndex)?.desc() {
//			print(frequencyDetailIndex)
//			currentCheckedAlcoholDetailLbl.text = "(" + subText + ")"
//		}
//	}
//
//	@objc private func showPopup(text: UILabel) {
//		//TODO: HaiPT15
//		//		let userVC = AlcoholPopUpViewController()
//		//
//		//		let okAction = {
//		//
//		//			text.text = AlcoholLevel(rawValue: userVC.buttonChecked.tag)?.desc()
//		//			if let subText = AlcoholLevel(rawValue: userVC.buttonChecked.tag)?.desc() {
//		//				text.text = "(" + subText + ")"
//		//			} else {
//		//				if let textdesc = AlcoholLevel(rawValue: 1)?.desc() {
//		//					text.text = "(" + textdesc + ")"
//		//				}
//		//			}
//		//
//		//			if let drinkingLevelDetailIndex = AlcoholLevel(rawValue: userVC.buttonChecked.tag) {
//		//				self.drinkPerTime.onNext(drinkingLevelDetailIndex)
//		//			} else {
//		//				self.drinkPerTime.onNext(AlcoholLevel.lessthanOne)
//		//			}
//		//		}
//		//
//		//		//Get Text On Label
//		//		if var text = text.text {
//		//			text.removeFirst()
//		//			text.removeLast()
//		//			userVC.currentIndex = AlcoholLevel(name: text).rawValue
//		//		}
//		//
//		//		//------------------- show popup ------------------
//		//		let popup = GKPopup.showPopup(withVC: userVC,
//		//										   arrButton: [PopupStruct(title: "OK", action: okAction)])
//		//
//		//		viewController()?.present(popup, animated: true, completion: nil)
//	}
//
//	@IBAction private func checkedEveryday(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.everyday)
//
//		showPopup(text: firstText)
//	}
//
//	@IBAction private func checkedFiveToSixTimesPerWeek(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.fiveToSixTimesPerWeek)
//
//		showPopup(text: secondText)
//	}
//
//	@IBAction private func checkedThreeToFourTimesPerWeek(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.threeToFourTimesPerWeek)
//
//		showPopup(text: thirdText)
//	}
//
//	@IBAction private func checkedOneToTwoTimesPerWeek(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.oneToTwoTimesPerWeek)
//
//
//		showPopup(text: fourthText)
//	}
//
//	@IBAction private func checkedOneToThreePerMonth(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.oneToThreePerMonth)
//
//
//		showPopup(text: fifthText)
//	}
//
//	@IBAction private func checkedStopForMoreThanOneYear(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.stopForMoreThanOneYear)
//	}
//
//	@IBAction private func checkedCanNotDrink(_ sender: UIButton) {
//		changeStatusCheckbox(buttonTaped: sender, listButton: frequencies)
//		frequency.onNext(.canNotDrink)
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
//		if index > listText.count {
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
