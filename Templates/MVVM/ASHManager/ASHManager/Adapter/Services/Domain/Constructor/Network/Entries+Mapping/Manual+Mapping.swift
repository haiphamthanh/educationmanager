//
//  Manual+Mapping.swift
//  ASHManager
//
//  Created by NamPC on 3/23/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import ObjectMapper

extension ManualMapped: ImmutableMappable {
	
	public init(map: Map) throws {
		status = try map.value("status")
		body = try map.value("body")
	}
}
