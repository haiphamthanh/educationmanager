//
//  DataStoreProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

protocol DataStoreProtocol {
	// MARK: ================================= User =================================
	func create(users: [UserData]) -> [UserData]?
	func user(from ids: [Int]) -> [UserData]?
	func update(users: [UserData]) -> [UserData]?
	func delete(userIds: [Int]) -> [UserData]?
	
	// MARK: ================================= Account =================================
//	func create(account: AccountData) -> AccountData?
//	func account() -> AccountData?
//	func update(account: AccountData) -> AccountData?
//	func delete(account: AccountData) -> AccountData?
}
