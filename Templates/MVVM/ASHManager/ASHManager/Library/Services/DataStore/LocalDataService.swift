//
//  LocalDataService.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

class LocalDataService: LocalDataServiceProtocol {
	
	// MARK: =========== User ===========
	func create(users: [UserProtocol]) -> [UserProtocol]? {
		let task = CreateUserTask(users: users)
		return task.execute()
	}
	
	func user(from ids: [Int]) -> [UserProtocol]? {
		let task = ReadUserTask(ids: ids)
		return task.execute()
	}
	
	func update(users: [UserProtocol]) -> [UserProtocol]? {
		let task = UpdateUserTask(users: users)
		return task.execute()
	}
	
	func delete(userIds: [Int]) -> [UserProtocol]? {
		let task = DeleteUserTask(ids: userIds)
		return task.execute()
	}
	
	// MARK: =========== Account ===========
	func create(account: AccountProtocol) -> AccountProtocol? {
		let task = CreateAccountTask(account: account)
		return task.execute()?.first
	}
	
	func account() -> AccountProtocol? {
		let task = ReadAccountTask()
		return task.execute()?.first
	}
	
	func update(account: AccountProtocol) -> AccountProtocol? {
		let task = UpdateAccountTask(account: account)
		return task.execute()?.first
	}
	
	func delete(account: AccountProtocol) -> AccountProtocol? {
		let task = DeleteAccountTask(account: account)
		return task.execute()?.first
	}
}
