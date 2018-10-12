//
//  PostsUseCase.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/25/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import CoreLocation

/**
Provide methods using for User action
*/
protocol UserUseCase {
	func register(user: UserData) -> Observable<AuthData>
	func userDetail() -> Observable<UserData>
	func update(user: UserData) -> Observable<Void>
	func change(password: String, of userName: String) -> Observable<Void>
}
