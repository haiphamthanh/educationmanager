//
//  Int+TimeConverter.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

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
