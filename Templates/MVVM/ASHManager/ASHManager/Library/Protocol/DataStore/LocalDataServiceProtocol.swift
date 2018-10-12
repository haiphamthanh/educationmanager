//
//  LocalDataServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/12/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

protocol LocalDataServiceProtocol {
	// MARK: ================================= User =================================
	func create(users: [UserProtocol]) -> [UserProtocol]?
	func user(from ids: [Int]) -> [UserProtocol]?
	func update(users: [UserProtocol]) -> [UserProtocol]?
	func delete(userIds: [Int]) -> [UserProtocol]?
	
	// MARK: ================================= Account =================================
	func create(account: AccountProtocol) -> AccountProtocol?
	func account() -> AccountProtocol?
	func update(account: AccountProtocol) -> AccountProtocol?
	func delete(account: AccountProtocol) -> AccountProtocol?
}
