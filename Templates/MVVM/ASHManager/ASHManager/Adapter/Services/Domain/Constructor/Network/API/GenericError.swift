//
//  GenericError.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/23/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper
import Moya

final class GenericError: Mappable {
	var detail: [String:AnyObject]?
	var message: String?
	var type: String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		detail	<- map["detail"]
		message	<- map["message"]
		type	<- map["type"]
	}
}

extension NSError {
	func serverError() -> NSString {
		if let errorJSON = userInfo["data"] as? [String: AnyObject] {
			let error =  GenericError(JSON: errorJSON)
			return "\(String(describing: error?.message)) - \(String(describing: error?.detail)) + \(String(describing: error?.detail))" as NSString
		} else if let response = userInfo["data"] as? Response {
			let stringData = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue)
			return "Status Code: \(response.statusCode), Data Length: \(response.data.count), String Data: \(String(describing: stringData))" as NSString
		}
		
		return "\(userInfo)" as NSString
	}
}
