//
//  RMUserInfo+Mapping.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

extension RMUserInfo: DomainConvertibleType {
	func asDomain() -> UserInfoEntry {
		return UserInfoEntry(uid: uid,
							 role_id: role_id,
							 nickName: nickName,
							 username: username,
							 email: email,
							 birthday: birthday,
							 gender: gender,
							 avatar: avatar,
							 picture: picture,
							 first_name: first_name,
							 last_name: last_name,
							 latitude: latitude,
							 longitude: longitude,
							 address: address,
							 token: token,
							 refreshToken: refreshToken,
							 expiry: expiry,
							 created_at: created_at,
							 updated_at: updated_at)
	}
}

extension UserInfoEntry: RealmRepresentable {
	func asRealm() -> RMUserInfo {
		return RMUserInfo.build { object in
			object.uid = uid
			object.role_id = role_id
			object.nickName = nickName
			object.username = username
			object.email = email
			object.birthday = birthday
			object.gender = gender
			object.avatar = avatar
			object.picture = picture
			object.first_name = first_name
			object.last_name = last_name
			object.latitude = latitude
			object.longitude = longitude
			object.address = address
			object.token = token
			object.refreshToken = refreshToken
			object.expiry = expiry
			object.created_at = created_at
			object.updated_at = updated_at
		}
	}
}
