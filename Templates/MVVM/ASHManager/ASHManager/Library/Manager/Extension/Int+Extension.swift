//
//  Int+Extension.swift
//  ASHManager
//
//  Created by TienNT12 on 4/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

extension Int {
	
	var mbTobytes: UInt64 {
		return UInt64(self) * 1024 * 1024
	}
	
	func convertStepToMoney() -> String {
		if self > 0 {
			let money = 0.065 * Double(self)
			return "\(Int(money.rounded()).toString())" + LocalizedString.monneyTitle()
		}
		return "--" + LocalizedString.monneyTitle()
	}
	
	func convertGPoint() -> String {
		let money = 0.065 * Double(self)
		let gpoint = 0.007 * money
		return "\(Int(gpoint.rounded()).toString())"
	}
}
