//
//  DeviceUseCase.swift
//  ASHManager
//
//  Created by KhoaLA on 4/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol DeviceUseCase {
	func gobeProfile(userName: String, password: String) -> Observable<UserData>
	func fitbitProfile(from code: String) -> Observable<UserData>
}
