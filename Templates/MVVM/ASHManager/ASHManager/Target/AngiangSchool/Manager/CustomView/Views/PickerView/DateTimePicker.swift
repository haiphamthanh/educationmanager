//
//  DateTimePicker.swift
//  ASHManager
//
//  Created by ToanNV11 on 12/25/17.
//  Copyright © 2017 net.toan. All rights reserved.
//

import UIKit

enum CutomizePickerType: String {
	case DayMonth
	case MonthYear
	case DayMonthYear
	case JapanDate
}

@objc protocol CutomizePickerDelegate: class {
	@objc optional func cutomizePicker(in cutomizePicker: DateTimePicker, didSelectDate: String, selectedDateFull: String)
	@objc optional func cutomizePicker(in cutomizePicker: DateTimePicker, didSelectDay: NSInteger, month: NSInteger, year: NSInteger)
}

let minYear = 1900

class DateTimePicker: UIPickerView {
	
	internal var months: [String] = []
	var currentDay: NSInteger?
	var currentMonth: NSInteger?
	var currentYear: NSInteger?
	var currentDate: String?
	private var componentWidth: CGFloat = 0
	private var defaultDateTime: Date?
	
	var pickerType = CutomizePickerType.DayMonthYear {
		didSet {
			switch pickerType {
			case .MonthYear:
				componentWidth = (frame.size.width * 10.0) / 100
			case .JapanDate:
				componentWidth = (frame.size.width * 10.0) / 100
			case .DayMonthYear:
				componentWidth = (frame.size.width * 10.0) / 100
			default:
				componentWidth = (frame.size.width * 10.0) / 100
			}
			
			reloadAllComponents()
			setNeedsLayout()
			
			let day = NSCalendar.current.component(.day, from: Date.lastDateTimeFromDistanceYears())
			let month = NSCalendar.current.component(.month, from: Date.lastDateTimeFromDistanceYears())
			let year = NSCalendar.current.component(.yearForWeekOfYear, from: Date.lastDateTimeFromDistanceYears())
			
			gotoDay(day: day, month: month, year: year)
		}
	}
	
	weak var cutomizePickerDelegate: CutomizePickerDelegate?
	override func awakeFromNib() {
		super.awakeFromNib()
		
		configSystem()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configSystem()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		configSystem()
	}
	
	private func updateDate() {
		let splat = LocalizedString.titleEnBirthday()
		switch pickerType {
		case .DayMonth:
			currentDate = "\(currentMonth!)\(LocalizedString.titleMonth()) \(currentDay!)\(LocalizedString.titleDay())"
		case .MonthYear:
			currentDate = "\(currentYear!)\(LocalizedString.titleYear()) \(currentMonth!)\(LocalizedString.titleMonth())"
		case .DayMonthYear:
			currentDate = "\(currentYear!)\(LocalizedString.titleYear()) \(splat) \(currentMonth!)\(LocalizedString.titleMonth()) \(splat) \(currentDay!)\(LocalizedString.titleDay())"
		default:
			currentDate = "\(currentYear!)\(LocalizedString.titleYear()) \(splat) \(currentMonth!)\(LocalizedString.titleMonth()) \(splat) \(currentDay!)\(LocalizedString.titleDay())"
		}
		
		var month = "\(currentMonth!)"
		var day = "\(currentDay!)"
		
		if currentMonth! < 10 {
			month = "0" + month
		}
		
		if currentDay! < 10 {
			day = "0" + day
		}
		
		if let method = cutomizePickerDelegate?.cutomizePicker(in:didSelectDate:selectedDateFull:) {
			method(self, currentDate!, "\(currentYear!)\(month)\(day)")
		}
		
		if let method = cutomizePickerDelegate?.cutomizePicker(in:didSelectDay:month:year:) {
			method(self, currentDay!, currentMonth!, currentYear!)
			return
		}
		
		setNeedsLayout()
		self.reloadAllComponents()
	}
	
	private func configSystem() {
		delegate = self
		dataSource = self
		showsSelectionIndicator = true
		backgroundColor = UIColor.clear
		componentWidth = (frame.size.width * 30.0) / 100
		
		let df = DateFormatter()
		
		df.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
		months = df.monthSymbols
		
		defaultDateTime = Date.lastDateTimeFromDistanceYears()
		let day = NSCalendar.current.component(.day, from: defaultDateTime!)
		let month = NSCalendar.current.component(.month, from: defaultDateTime!)
		let year = NSCalendar.current.component(.yearForWeekOfYear, from: defaultDateTime!)
		
		gotoDay(day: day, month: month, year: year)
	}
	
	func gotoDay(day: NSInteger, month: NSInteger, year: NSInteger) {
		currentYear = year
		currentMonth = month
		currentDay = day
		
		selectRow(year - minYear, inComponent: 0, animated: true)
		selectRow(month - 1, inComponent: 1, animated: true)
		selectRow(day - 1, inComponent: 2, animated: true)
		updateDate()
	}
	
	
	static func currentSystemDate() -> String {
		let date = Date()
		let formatter = DateFormatter()
		
		formatter.dateFormat = "yyyy/MM/dd"
		return formatter.string(from: date)
	}
	
	static func formatToJapanYYYYMMDD(date: NSDate) -> String {
		let day = Calendar.current.component(.day, from: Date())
		let month = Calendar.current.component(.month, from: Date())
		let year = Calendar.current.component(.yearForWeekOfYear, from: Date())
		
		return "\(year)\(LocalizedString.titleYear()) \(month)\(LocalizedString.titleMonth()) \(day)\(LocalizedString.titleDay())"
	}
	
	static func formatToJapanMMDD(date: NSDate) -> String {
		let month = Calendar.current.component(.month, from: Date())
		let day = Calendar.current.component(.day, from: Date())
		
		return "\(month)\(LocalizedString.titleMonth()) \(day)\(LocalizedString.titleDay())"
	}
	
	static func formatToJapanMMDDWD(date: NSDate) -> String {
		
		let DD = Calendar.current.component(.day, from: Date())
		let MM = Calendar.current.component(.month, from: Date())
		
		var month = ""
		var day = ""
		
		if MM < 10 {
			month = "0\(MM)"
		} else {
			month = "\(MM)"
		}
		
		if DD < 10 {
			day = "0\(DD)"
		} else {
			day = "\(DD)"
		}
		
		return "\(month)" + "\(LocalizedString.titleMonth())" + " " +  "\(day)" + "\(LocalizedString.titleDay())"
	}
	
	static func dateFromString(date: String) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: date)!
	}
	
	static func hourFromString(date: String) -> String {
		
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "HH:mm"
		
		let formatter = DateFormatter()
		return dateFormatter.string(from: formatter.date(from: date)!)
	}
}

extension DateTimePicker: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 3
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if (component == 0) {
			if pickerType == .DayMonth {
				return 0
			}
			
			return NSCalendar.current.component(.yearForWeekOfYear, from: defaultDateTime!) - minYear + 1
		}
		
		if (component == 1) {
			if currentYear == NSCalendar.current.component(.yearForWeekOfYear, from: Date()) {
				return NSCalendar.current.component(.month, from: defaultDateTime!)
			}
			
			if currentYear == Date.dateComponentFromDistanceYears().year {
				return Date.dateComponentFromDistanceYears().month!
			}
			
			return 12
		}
		
		if pickerType == .MonthYear {
			return 0
		}
		currentYear = pickerType == .DayMonth ? 2016 : currentYear!
		var selectMothComps = DateComponents()
		selectMothComps.year = currentYear!
		selectMothComps.month = currentMonth!
		selectMothComps.day = 1
		
		var nextMothComps = DateComponents()
		nextMothComps.year = currentYear!
		nextMothComps.month = currentMonth! + 1
		nextMothComps.day = 1
		
		let thisMonthDate = NSCalendar.current.date(from: selectMothComps)
		let nextMonthDate = NSCalendar.current.date(from: nextMothComps)
		
		let differnce = NSCalendar.current.dateComponents([.day], from: thisMonthDate!, to: nextMonthDate!)
		
		if currentYear == NSCalendar.current.component(.yearForWeekOfYear, from: defaultDateTime!)
			&& currentMonth == NSCalendar.current.component(.month, from: defaultDateTime!) {
			return NSCalendar.current.component(.day, from: defaultDateTime!)
		}
		
		return differnce.day!
	}
}

extension DateTimePicker: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch component {
		case 0:
			return "\(row + minYear)\(LocalizedString.titleYear())"
		case 1:
			return "\(row + 1)\(LocalizedString.titleMonth())"
		default:
			return "\(row + 1)\(LocalizedString.titleDay())"
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch component {
		case 0:
			currentYear = row + minYear
			reloadComponent(1)
			currentMonth = pickerView.selectedRow(inComponent: 1) + 1
			reloadComponent(2)
			currentDay = pickerView.selectedRow(inComponent: 2) + 1
		case 1:
			currentMonth = row + 1
			reloadComponent(2)
			currentDay = pickerView.selectedRow(inComponent: 2) + 1
		default:
			currentDay = row + 1
		}
		updateDate()
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		if component == 0 && pickerType == .DayMonth {
			return 0
		}
		
		if component == 2 && pickerType == .MonthYear {
			return 0
		}
		
		return componentWidth
	}
}

