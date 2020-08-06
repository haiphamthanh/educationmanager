//
//  Array+Extension.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 3/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Charts

extension Array where Element == Double {
	func pieEntries() -> [PieChartDataEntry] {
		let sum = reduce(0, +)
		
		let entries = map { value -> PieChartDataEntry in
			let dur = Swift.max(0, value)
			return PieChartDataEntry(value: (dur / sum * 100))
		}
		
		return entries
	}
}

extension Array where Element == (time: Double, value: Double) {
	func lineEntries() -> [ChartDataEntry] {
		let entries = map { data -> ChartDataEntry in
			return ChartDataEntry(x: data.time, y: data.value)
		}
		
		return entries
	}
	
	func barEntries() -> [BarChartDataEntry] {
		let entries = map { data -> BarChartDataEntry in
			return BarChartDataEntry(x: data.time, y: data.value)
		}
		
		return entries
	}
}

extension Array where Element : Hashable {
	var unique: [Element] {
		return Array(Set(self))
	}
}
