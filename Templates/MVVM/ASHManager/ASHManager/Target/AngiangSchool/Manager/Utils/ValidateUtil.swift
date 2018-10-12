//
//  Validate.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

enum DateFormat: String {
	case year_month_date_format_api = "yyyy-MM-dd"
	case year_month_date_hour_minute_second = "yyyy-MM-dd HH:mm:ss"
	case year_month_date_hour_minute_second_mili = "yyyy-MM-dd HH:mm:ss.SSSSSS"
	case year_month_format = "MM'月,' yyyy'年'"
	case year_format = "yyyy'年'"
	case cal_e_y_M_d_format = "cal_e_y_M_d_format"
	case cal_y_M_d_format = "cal_y_M_d_format"
	case cal_y_m_format = "cal_y_m_format"
}

class Validate {
	
	static func isValidDateTimeFormat(date: String, format: DateFormat) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format.rawValue
		if (dateFormatter.date(from: date) != nil) {
			return nil
		}
		
		return LocalizedString.localizedString(input: "Datetime_Error_Message")
	}
	
	static func isValidEmail(email: String?) -> String? {
		if let message = isValidAuthInputLength(inputString: email) {
			return message
		}
		
		let REGEX: String
		REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
		return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email) ? nil : LocalizedString.localizedString(input: "Email_not_Valid_Error_Message")
	}
	
	static func isValidAuthInputLength(inputString: String?) -> String? {
		guard let inputString = inputString else {
			return LocalizedString.localizedString(input: "Input_Length_not_Valid_Error_Message")
		}
		
		let trimmedString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		if let message = isValidInputEmpty(inputString: trimmedString) {
			return message
		}
		return trimmedString.count >= 8
			&& trimmedString.count <= 255 ? nil : LocalizedString.localizedString(input: "Input_Length_not_Valid_Error_Message")
	}
	
	static func isValidOptionalInput(inputString: String) -> String? {
		let trimmedString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
		return trimmedString.count >= 0
			&& trimmedString.count <= 255 ? nil : LocalizedString.localizedString(input: "Input_Optional_Length_not_Valid_Error_Message")
	}
	
	static func isValidAuthInput(newPassword: String?, confirmPassword: String?) -> String? {
		guard let newPassword = newPassword, let confirmPassword = confirmPassword else {
			return LocalizedString.localizedString(input: "Input_Length_not_Valid_Error_Message")
		}
		
		let newTrimmedString = newPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		let confirmTrimmedString = confirmPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return newTrimmedString.caseInsensitiveCompare(confirmTrimmedString) == .orderedSame ? nil : LocalizedString.localizedString(input: "Password_Confirm_Error_Message")
	}
	
	static func isValidInputMaxLength(inputString: String) -> String? {
		let trimmedString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return trimmedString.count <= 255 ? nil : inputString + LocalizedString.localizedString(input: "Input_Max_Length_Error_Message")
	}
	
	static func isValidAvatarInputLength(inputString: String) -> String? {
		let trimmedString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return trimmedString.count <= 1024 ? nil : inputString + LocalizedString.localizedString(input: "Avatar_Max_Length_Error_Message")
	}
	
	static func isValidInputEmpty(inputString: String) -> String? {
		let trimmedString = inputString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return !trimmedString.isEmpty ? nil : LocalizedString.localizedString(input: "Input_Empty_Error_Message")
	}
	
	static func isValidMeasureWeight(weight: Double) -> String? {
		return (isValidMeasurement(measure: weight)) ? nil : LocalizedString.localizedString(input: "Input_Weight_Error_Message")
	}
	
	static func isValidMeasureHeight(height: Double) -> String? {
		return (isValidMeasurement(measure: height)) ? nil : LocalizedString.localizedString(input: "Input_Height_Error_Message")
	}
	
	static func isValidAgreeTermOfUseAndPolicy(isAgree: Bool) -> String? {
		return isAgree ? nil : LocalizedString.localizedString(input: "Dont_Check_TermsOfUse_Error_Message_02")
	}
	
	private static func isValidMeasurement(measure: Double) -> Bool {
		return measure != 0
	}
	
	static func isValidStartDate(date: String) -> Bool {
		return true
	}
}
