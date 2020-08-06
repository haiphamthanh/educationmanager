//
//  DataStoreProvider.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/14/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

final class DataStoreProvider {
	func makeUserDataStore() -> UserDataStore {
		return UserDataStore.init()
	}
}
