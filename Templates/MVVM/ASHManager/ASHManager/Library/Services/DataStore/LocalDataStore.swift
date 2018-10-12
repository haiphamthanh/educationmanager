//
//  LocalDataStore.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

class LocalDataStore: LocalDataStoreProtocol {
	// MARK: - ================================= Properties =================================
	private let localDataService: LocalDataServiceProtocol
	
	// MARK: - ================================= Init =================================
	init(localDataService: LocalDataServiceProtocol) {
		self.localDataService = localDataService
	}
	
	// MARK: ================================= User =================================
	func create(users: [UserData]) -> [UserData]? {
		var listLocalUser = [UserProtocol]()
		for item in users {
			listLocalUser.append(LocalUserData.init(userData: item))
		}
		
		var listUser = [UserData]()
		if let result = localDataService.create(users: listLocalUser) {
			for item in result {
				listUser.append(item.toData())
			}
		}
		
		return listUser
	}
	
	func user(from ids: [Int]) -> [UserData]? {
		var listUser = [UserData]()
		if let result = localDataService.user(from: ids) {
			for item in result {
				listUser.append(item.toData())
			}
		}
		
		return listUser
	}
	
	func update(users: [UserData]) -> [UserData]? {
		var listLocalUser = [UserProtocol]()
		for item in users {
			listLocalUser.append(LocalUserData.init(userData: item))
		}
		
		var listUser = [UserData]()
		if let result = localDataService.update(users: listLocalUser) {
			for item in result {
				listUser.append(item.toData())
			}
		}
		
		return listUser
	}
	
	func delete(userIds: [Int]) -> [UserData]? {
		var listUser = [UserData]()
		if let result = localDataService.delete(userIds: userIds) {
			for item in result {
				listUser.append(item.toData())
			}
		}
		
		return listUser
	}
	
	// MARK: ================================= Account =================================
	func create(account: AccountData) -> AccountData? {
		let localAccount = LocalAccountData(account: account)
		if let accountData = localDataService.create(account: localAccount) {
			return accountData.toData()
		}
		
		return nil
	}
	
	func account() -> AccountData? {
		if let accountData = localDataService.account() {
			return accountData.toData()
		}
		
		return nil
	}
	
	func update(account: AccountData) -> AccountData? {
		let localAccount = LocalAccountData(account: account)
		if let accountData = localDataService.update(account: localAccount) {
			return accountData.toData()
		}
		
		return nil
	}
	
	func delete(account: AccountData) -> AccountData? {
		let localAccount = LocalAccountData(account: account)
		if let accountData = localDataService.delete(account: localAccount) {
			return accountData.toData()
		}
		
		return nil
	}
}
