//
//  RMUser+Mapping.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

extension RMUser: DomainConvertibleType {
	func asDomain() -> UserEntry {
		return UserEntry(uid: uid,
						 userInfo: userInfo!.asDomain(),
						 health: health!.asDomain())
	}
}

extension UserEntry: RealmRepresentable {
	func asRealm() -> RMUser {
		return RMUser.build { object in
			object.uid = uid
			object.userInfo = userInfo.asRealm()
			object.health = health.asRealm()
		}
	}
}
