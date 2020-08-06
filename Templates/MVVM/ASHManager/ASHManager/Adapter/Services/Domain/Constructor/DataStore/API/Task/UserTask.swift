//
//  UserTask.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/12/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import RealmSwift
import QueryKit

class UserTask: LocalBaseTask<UserEntry> {
	fileprivate var user: UserEntry?
	fileprivate var id: String?
	
	init(user: UserEntry?, configuration: Realm.Configuration = Realm.Configuration()) {
		super.init(configuration: configuration)
		
		self.user = user
	}
	
	init(id: String? = nil, configuration: Realm.Configuration = Realm.Configuration()) {
		super.init(configuration: configuration)
		
		self.id = id
	}
}

class CreateUserTask: UserTask {
	override func execute() -> Observable<[UserEntry]> {
		guard let user = user else {
			return rxDDLogWarn("Can't find user to save")
		}
		
		return repository.save(entity: user)
	}
}

class ReadUserTask: UserTask {
	override func execute() -> Observable<[UserEntry]> {
		var predicate: NSPredicate?
		if let id = id {
			predicate = (RMUser.uid == id)
		}
		
		if predicate == nil {
			return repository.queryAll()
		}
		
		return repository.query(with: predicate!,
								sortDescriptors: [UserEntry.RealmType.uid.descending()])
		
	}
}

class UpdateUserTask: UserTask {
	override func execute() -> Observable<[UserEntry]> {
		guard let user = user else {
			return rxDDLogWarn("Can't find user to save")
		}
		
		return repository.save(entity: user)
	}
}

class DeleteUserTask: UserTask {
	override func execute() -> Observable<[UserEntry]> {
		guard let user = user else {
			return rxDDLogWarn("Can't find user to delete")
		}
		
		return repository.delete(entity: user)
	}
}

