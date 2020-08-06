//
//  HealthEntry.swift
//  ASHManager
//
//  Created by HieuNT52 on 1/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension HealthEntry: ImmutableMappable {
	// JSON -> Object
	init(map: Map) throws {
		uid = try map.value("uid", using: UidTransform())
		height = (try? map.value("height")) ?? 0
		weight = (try? map.value("weight")) ?? 0
		blood_type = (try? map.value("blood_type")) ?? BloodType.a.rawValue
	}
}
