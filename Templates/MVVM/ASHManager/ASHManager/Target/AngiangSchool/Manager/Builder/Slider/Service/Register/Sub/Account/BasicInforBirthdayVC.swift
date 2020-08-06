//
//  BasicInforBirthdayVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import RxGesture

class BasicInforBirthdayVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var birthDateTextField: ASEDateTextField!
	
	private let pBirthDay = PublishSubject<String>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforBirthdayVC {
	var birthDay: Observable<String> {
		return pBirthDay
	}
	
	func selected(birthDay: String) {
		return movePicker(toDate: birthDay)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforBirthdayVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.birthdayTitle()
//		birthDateTextField.dateTextFieldDelegate = self
	}
	
	func subcribeSetup() {
	}
	
	func movePicker(toDate: String) {
		let comps = toDate.components(separatedBy: "-")
		if comps.count == 3 {
//			let dateTime = Date.lastDateTimeFromDistanceYears()
			
//			let day = comps.count == 3 ? Int(comps[2])! : NSCalendar.current.component(.day, from: dateTime)
//			let month = comps.count == 3 ? Int(comps[1])! : NSCalendar.current.component(.month, from: dateTime)
//			let year = comps.count == 3 ? Int(comps[0])! : NSCalendar.current.component(.yearForWeekOfYear, from: dateTime)
			
//			birthDateTextField.datePicker.gotoDay(day: day, month: month, year: year)
		}
	}
}

//extension BasicInforBirthdayVC: DateTextFieldDelegate {
//	func dateChange(textField: DateTextField, selectDate: String, selectedDateFull: String) {
//		pBirthDay.onNext(selectDate)
//	}
//}
