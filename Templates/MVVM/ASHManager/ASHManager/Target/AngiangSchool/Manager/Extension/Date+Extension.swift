//
//  Date+Extension.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/28/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

extension Date {
	static let DISTANCE_DATE_TIME = 13
	
	static func lastDateTimeFromDistanceYears(_ distanceYears: Int = DISTANCE_DATE_TIME) -> Date {
		return Calendar.current.date(from: dateComponentFromDistanceYears(distanceYears))!
	}
	
	static func dateComponentFromDistanceYears(_ distanceYears: Int = DISTANCE_DATE_TIME) -> DateComponents {
		let lastYear = Calendar.current.component(.year, from: Date()) - distanceYears
		let month =  Calendar.current.component(.month, from: Date())
		let day =  Calendar.current.component(.day, from: Date())
		return DateComponents(year: lastYear, month: month, day: day)
	}
	
	static func getDateTime(day: Int, month: Int, year: Int) -> Date {
		let dateComponents = DateComponents(year: year, month: month, day: day)
		return Calendar.current.date(from: dateComponents)!
	}
	
	/// formatString: the format date converted from string
	func toString(withFormat formatString: String? = nil) -> String {
		var realFormat: String!
		let dateFormatter = DateFormatter()
		if let tempFormat = formatString {
			realFormat = tempFormat
		} else {
			realFormat = LocalizedString.dateFormatter()
		}
		dateFormatter.dateFormat = realFormat
		return dateFormatter.string(from: self)
	}
	
	var startOfWeek: Date? {
		let gregorian = Calendar(identifier: .gregorian)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 0, to: sunday)
	}
	
	var endOfWeek: Date? {
		let gregorian = Calendar(identifier: .gregorian)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 7, to: sunday)
	}
	
	func isToday() -> Bool {
		let calendar = Calendar.current
		let select = self
		let current = Date()
		
		let currentDay = calendar.component(.day, from: select)
		let currentMonth = calendar.component(.month, from: select)
		let currentYear = calendar.component(.year, from: select)
		let selectDay = calendar.component(.day, from: current)
		let selectMonth = calendar.component(.month, from: current)
		let selectYear = calendar.component(.year, from: current)
		
		if currentDay == selectDay && currentMonth == selectMonth && currentYear == selectYear {
			return true
		} else {
			return false
		}
	}
}

extension Date {
	func elapsedInterval() -> String {
		let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
		
		if let year = interval.year, year > 0 {
			return year == 1 ? "\(year)" + " " + LocalizedString.localizedString(input: "Content_Comment_Year") :
				"\(year)" + " " + LocalizedString.localizedString(input: "Content_Comment_Years")
		} else if let month = interval.month, month > 0 {
			return month == 1 ? "\(month)" + " " + LocalizedString.localizedString(input: "Content_Comment_Month") :
			"\(month)" + " " + LocalizedString.localizedString(input: "Content_Comment_Months")
		} else if let day = interval.day, day > 0 {
			return day == 1 ? "\(day)" + " " + LocalizedString.localizedString(input: "Content_Comment_Day") :
			"\(day)" + " " + LocalizedString.localizedString(input: "Content_Comment_Days")
		} else if let hour = interval.hour, hour > 0 {
			return hour == 1 ? "\(hour)" + " " + LocalizedString.localizedString(input: "Content_Comment_Hour") :
				"\(hour)" + " " + LocalizedString.localizedString(input: "Content_Comment_Hours")
		} else if let minute = interval.minute, minute > 0 {
			return minute == 1 ? "\(minute)" + " " + LocalizedString.localizedString(input: "Content_Comment_Minute") :
				"\(minute)" + " " + LocalizedString.localizedString(input: "Content_Comment_Minutes")
		} else {
			return LocalizedString.localizedString(input: "Content_Comment_Just_Now")
		}
	}
}
