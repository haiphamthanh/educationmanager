//
//  CalendarUtils.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/28/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

enum DateSelectionType: Int {
	case day = 0
	case week
	case month
	case year
}

enum DateConvert: Int {
	case minute
	case hour = 1
	case day
	case week
	case month
	case year
}

enum DayNightDivision: String {
	case am = "am"
	case pm = "pm"
}

class CalendarUtil {
	static func getCurrentDate() -> (day: Int, week: Int, month: Int, year: Int) {
		let date = Date()
		let calendar = Calendar.current
		let day = calendar.component(.day, from: date)
		let week = calendar.component(.weekOfMonth, from: date)
		let month = calendar.component(.month, from: date)
		let year = calendar.component(.year, from: date)
		
		return (day, week, month, year)
	}
	
	static func getDateTimeTitle(fromDate: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = LocalizedString.localizedString(input: DateFormat.cal_e_y_M_d_format.rawValue)
		return dateFormatter.string(from: fromDate)
	}
	
	static func getWeekTimeTitle(fromDate: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = LocalizedString.localizedString(input: DateFormat.cal_y_M_d_format.rawValue)
		let weekend = fromDate.addingTimeInterval(6*86400)
		return "\(dateFormatter.string(from: fromDate)) - \(Calendar.current.component(.day, from: weekend))\(LocalizedString.localizedString(input: "Title_Infomation_Day"))"
	}
	
	static func getMonthYearTitle(fromDate: Date) -> String {
		let dateformatter = DateFormatter()
		dateformatter.dateFormat = LocalizedString.localizedString(input: DateFormat.cal_y_m_format.rawValue)
		return dateformatter.string(from: fromDate)
	}
	
	static func getYearTitle(fromDate: Date) -> String {
		let dateformatter = DateFormatter()
		dateformatter.dateFormat = DateFormat.year_format.rawValue
		return dateformatter.string(from: fromDate)
	}
	
	static func getPastTime(type: DateSelectionType) -> [Date] {
		switch type {
		case .day:
			let today = Date()
			let result = (-750...0).flatMap{ Calendar.current.date(byAdding: .day, value: $0, to: today) }
			return result
		case .week:
			let today = Date().startOfWeek!
			let result = (-96...0).flatMap{ Calendar.current.date(byAdding: .weekOfMonth, value: $0, to: today) }
			return result
		case.month:
			let today = Date()
			let result = (-24...0).flatMap{ Calendar.current.date(byAdding: .month, value: $0, to: today) }
			return result
		case .year:
			let today = Date()
			let result = (-5...0).flatMap{ Calendar.current.date(byAdding: .year, value: $0, to: today) }
			return result
		}
	}
	
	static func convertTimeToString(type: DateSelectionType, date: Date) -> String {
		let dateFormatter = DateFormatter()
		switch type {
		case .day:
			dateFormatter.dateFormat = "dd"
			return dateFormatter.string(from: date)
		case .week:
			dateFormatter.dateFormat = "dd"
			return dateFormatter.string(from: date)
		case .month:
			dateFormatter.dateFormat = "MMM"
			return dateFormatter.string(from: date)
		case .year:
			dateFormatter.dateFormat = "yyyy"
			return dateFormatter.string(from: date)
		}
	}
	
	static func convertTimeTo(type: DateConvert, timestamp: TimeInterval) -> Int {
		let dateFormatter = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: Date(timeIntervalSince1970: timestamp))
		switch type {
		case .day:
			return dateFormatter.day!
		case .week:
			return dateFormatter.weekOfYear!
		case .month:
			return dateFormatter.month!
		case .hour:
			return dateFormatter.hour!
		case .year:
			return dateFormatter.year!
		case .minute:
			return dateFormatter.minute!
		}
	}
}
