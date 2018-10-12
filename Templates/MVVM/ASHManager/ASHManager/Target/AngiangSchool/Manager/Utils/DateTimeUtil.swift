//
//  DateTimeUtil.swift
//  ASHManager
//
//  Created by NamPC on 2/28/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

enum DateTimeFormat: String {
	case one = "hha, dd MMM yyyy"
	case two = "yyyy/MM/dd"
}

final class DateTimeUtil {
	
	static func changeTime(_ dateStr: String, format: DateFormat = DateFormat.year_month_date_hour_minute_second_mili,
						   dateTimeFormat: String = LocalizedString.localizedString(input: "year_month_date_time_format")) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format.rawValue
		dateFormatter.locale = Locale(identifier: "en_US")
		
		let date = dateFormatter.date(from: dateStr)!
		dateFormatter.dateFormat = dateTimeFormat
		return dateFormatter.string(from: date)
	}
	
	static var dateSelectFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "hh:mm a"
		return dateFormatter
	}()
	
	static var dateShowFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "hh:mm a"
		return dateFormatter
	}()
	
	static var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
	
	static var dateUTCFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
	
	static var dateHealthCheckUTCFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = LocalizedString.localizedString(input: "year_month_date_contest_format")
		return dateFormatter
	}()
	
	static var dateHealthCheckFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = LocalizedString.localizedString(input: "year_month_date_contest_format")
		return dateFormatter
	}()
	
	static var dateTimeFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		return dateFormatter
	}()
	
	static var dateTimeSSCurrentFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter
	}()
	
	static var dateTimeSSFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter
	}()
	
	static var dateHourFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "yyyy-MM-dd HH"
		return dateFormatter
	}()
	
	static var timeWithSecFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "HH:mm:ss"
		return dateFormatter
	}()
	
	static var timeFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "HH:mm"
		return dateFormatter
	}()
	
	static var timeCurrentFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "HH:mm"
		return dateFormatter
	}()
	
	static var eraFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "eeee"
		return dateFormatter
	}()
	
	class func dateWithRemovedTime(time: TimeInterval) -> Date {
		return DateTimeUtil.dateFormatter.date(from: DateTimeUtil.dateFormatter.string(from: Date(timeIntervalSince1970: time)))!
	}
	
	class func dateWithRemovedMinute(time: TimeInterval) -> Date {
		return DateTimeUtil.dateHourFormatter.date(from: DateTimeUtil.dateHourFormatter.string(from: Date(timeIntervalSince1970: time)))!
	}
}
