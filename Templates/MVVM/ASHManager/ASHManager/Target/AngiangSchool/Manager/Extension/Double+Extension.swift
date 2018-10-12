//
//  Float+Extension.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

extension Double {
	func convertToString() -> String {
		if (self.remainder(dividingBy: 1) == 0) {
			return String(Int(self))
		}
		
		return String(self)
	}
	
	func feetToInches() -> Double {
		return self * 12
	}
	
	func inchesToFeet() -> Double {
		return self / 12
	}
	
	func rounded(toPlaces places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
	
	@available(iOS 10.0, *)
	func convertWeight(fromType: UnitMass, toType: UnitMass) -> Double? {
		let value = Measurement<UnitMass>(value: self, unit: fromType)
		
		let outputValue = value.converted(to: toType)
		if Locale.current.usesMetricSystem {
			return outputValue.value
		} else {
			return nil
		}
	}
	
	@available(iOS 10.0, *)
	func convertHeight(fromType: UnitLength, toType: UnitLength) -> Double? {
		let locale = Locale(identifier: "ja_JP")
		let value = Measurement<UnitLength>(value: self, unit: fromType)
		
		let outputValue = value.converted(to: toType)
		if locale.usesMetricSystem {
			return outputValue.value
		} else {
			return nil
		}
	}
}

extension Int {
	func minute() -> Double {
		return TimeInterval(self * 60)
	}
	
	func hour() -> Double {
		return minute() * 60
	}
	
	func day() -> Double {
		return hour() * 24
	}
}
