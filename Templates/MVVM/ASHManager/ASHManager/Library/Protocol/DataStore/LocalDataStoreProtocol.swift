//
//  LocalDataStoreProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/12/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

protocol LocalDataStoreProtocol {
	// MARK: ================================= User =================================
	func create(users: [UserData]) -> [UserData]?
	func user(from ids: [Int]) -> [UserData]?
	func update(users: [UserData]) -> [UserData]?
	func delete(userIds: [Int]) -> [UserData]?
	
	// MARK: ================================= Account =================================
	func create(account: AccountData) -> AccountData?
	func account() -> AccountData?
	func update(account: AccountData) -> AccountData?
	func delete(account: AccountData) -> AccountData?
}
