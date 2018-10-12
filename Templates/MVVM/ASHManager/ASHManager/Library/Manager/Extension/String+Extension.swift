//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import SwiftSoup

extension String {
	static let DATE_TIME_LOCAL = "ja_JP"
	
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
	
	func numberOfCharacter(character: Character) -> Int {
		let filteredCharacter: [Character] = self.filter({$0 == character})
		return filteredCharacter.count
	}
	
	func filterCharacter(by charactersIn: String = "01234567890.") -> String {
		let valueString = self.trimmingCharacters(in: CharacterSet(charactersIn: charactersIn).inverted)
		if valueString.first == "." { return "" }
		return "\(valueString)"
	}
	
	func formatDecimalNumber(withDefault Value: String = "1") -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 2
		formatter.numberStyle = .decimal
		formatter.locale = Locale(identifier: currentLocation.vietnam.locationCode())
		guard let castedDoubleValue = Double(self) as NSNumber? else { return Value }
		return formatter.string(from: castedDoubleValue)!
	}
	
	func trim() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	func toDouble() -> Double {
		guard let doubleValue = Double(self) else { return 0.0 }
		return doubleValue
	}
	
	func toInt() -> Int {
		guard let intValue = Int(self) else { return 0 }
		return intValue
	}
	
	@available(iOS 10.0, *)
	func convertCentimetersToFeetAndInches() -> String? {
		
		guard let value = Double(self) else { return nil }
		if isCurrentLocalUsesMetricSystem() {
				let centimetersValue = Measurement<UnitLength>(value: value, unit: UnitLength.centimeters)
				let feetValue = centimetersValue.converted(to: UnitLength.feet)
				let inchesValue = Measurement<UnitLength>(value: feetValue.value.truncatingRemainder(dividingBy: 1),
														  unit: .feet).converted(to: UnitLength.inches)
				return "\(Int(floor(feetValue.value))) / \(inchesValue.value.rounded(toPlaces: 2))"
		} else {
			return nil
		}
	}
	
	@available(iOS 10.0, *)
	func isCurrentLocalUsesMetricSystem() -> Bool {
		let locale = Locale(identifier: "ja_JP")
		if locale.usesMetricSystem {
			return true
		}
		return false
	}
	
	@available(iOS 10.0, *)
	func convertFeetAndInchesToCentimeters() -> String? {
		if isCurrentLocalUsesMetricSystem() {
			let componentsList = self.components(separatedBy: "/")
			let trimmedStringsList = componentsList.trim()
			let doubleValuesList = trimmedStringsList.toDouble()
			let firstCentimetersValue = doubleValuesList[0].convertHeight(fromType: .feet, toType: .centimeters) ?? 0.0
			let secondCentimetersValue = doubleValuesList[1].convertHeight(fromType: .inches, toType: .centimeters) ?? 0.0
			let centimetersValue = firstCentimetersValue + secondCentimetersValue
			return "\(centimetersValue.rounded())"
		} else {
			return nil
		}

	}

	func shorten(by length: Int = 0) -> String {
		if self.length > length {
			return (String(self.prefix(length)) + "...")
		}
		return self
	}
	
	func isValidUrl() -> Bool {
		if let url = URL(string: self) {
			return UIApplication.shared.canOpenURL(url)
		}
		return false
	}
	
	// formatString: current format of string needed to convert to date type
	func toDate(inFormat formatString: String = "yyyy-MM-dd") -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = formatString
		let date = dateFormatter.date(from: self)
		return date
	}
	
	var htmlToAttributedString: NSAttributedString? {
		guard let data = data(using: .utf8) else { return NSAttributedString() }
		do {
			return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
		} catch {
			return NSAttributedString()
		}
	}
	
	var htmlToString: String {
		do {
			let doc: Document = try SwiftSoup.parse(self)
			return try doc.text()
		} catch Exception.Error(_, _) {
			print("")
		} catch {
			print("")
		}
		
		return self
	}
	
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
											attributes: [NSAttributedStringKey.font: font], context: nil)
		
		return ceil(boundingBox.height)
	}
	
	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
											attributes: [NSAttributedStringKey.font: font], context: nil)
		
		return ceil(boundingBox.width)
	}
	
	func heightOfString(usingFont font: UIFont) -> CGFloat {
		let fontAttributes = [NSAttributedStringKey.font: font]
		let size = self.size(withAttributes: fontAttributes)
		return size.height
	}
}
