//
//  RMHealth+Mapping.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

extension RMHealth: DomainConvertibleType {
	func asDomain() -> HealthEntry {
		return HealthEntry(uid: uid,
						   height: height,
						   weight: weight,
						   blood_type: blood_type)
	}
}

extension HealthEntry: RealmRepresentable {
	func asRealm() -> RMHealth {
		return RMHealth.build { object in
			object.uid = uid
			object.height = height
			object.weight = weight
			object.blood_type = blood_type
		}
	}
}
