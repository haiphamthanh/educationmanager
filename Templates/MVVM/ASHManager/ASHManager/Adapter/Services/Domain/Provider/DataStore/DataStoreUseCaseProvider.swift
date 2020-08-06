//
//  DataStoreUseCaseProvider.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/14/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class DataStoreUseCaseProvider: DataStoreUseCaseProviderProtocol {
	private let dataStoreProvider: DataStoreProvider
	
	init() {
		dataStoreProvider = DataStoreProvider()
	}
	
	func makeUserUseCase() -> UserUseCase {
		return DataStoreUserUseCase(dataStore: dataStoreProvider.makeUserDataStore())
	}
	
	func makeAuthUseCase() -> AuthUseCase {
		fatalError("Don't support local")
	}
}
