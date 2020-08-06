//
//  BaseAPINetwork.swift
//  ASHManager
//
//  Created by HaiPT15 on 4/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import SwifterSwift
import ObjectMapper
import RxSwift

// Output
typealias OutNWUserVoid = (requestId: Int, result: Observable<Void>)
typealias OutNWUserData = (requestId: Int, result: Observable<UserData>)
typealias OutNWNewToken = (requestId: Int, result: Observable<String>)
typealias OutNWBool = (requestId: Int, result: Observable<Bool>)

protocol APIType {
	var addXAccess: Bool { get }
}

class BaseAPINetwork {
	let id = Date().nanosecond
}

// Utils
extension BaseAPINetwork {
	func didSignIn(user: UserData) -> UserData {
		var accessToken = XAccessToken()
		accessToken.token = user.userInfo.token
		accessToken.expiry = user.userInfo.expiry
		
		return user
	}
}

// Use for void requesting
struct VoidEntry: ImmutableMappable {
	init(map: Map) throws {
	}
}

extension BaseAPINetwork {
	func transformToVoid(_: VoidEntry) -> Void {
		return
	}
}
