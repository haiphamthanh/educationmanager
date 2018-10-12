//
//  ResponseObject.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/3/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

struct ResponseObject {
    let status: Int
    let body: Any
	let arrayError: [String]?
	
    init(status: Int, body: Any) {
        self.status = status
        self.body = body
		self.arrayError = nil
    }
}

extension ResponseObject: ImmutableMappable {
    // JSON -> Object
    init(map: Map) throws {
        status = try map.value("status")
        body = try map.value("body")
		arrayError = (try? map.value("body")) ?? nil
    }
}


struct VoidObject {
}

extension VoidObject: ImmutableMappable {
	init(map: Map) throws {
	}
	
}
