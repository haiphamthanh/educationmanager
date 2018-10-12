//
//  SocialData.swift
//  ASHManager
//
//  Created by KhoaLA on 5/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

enum SocialNetwork {
	case Facebook
	case GooglePlus
}

struct SocialData {
	let userInfo: SocialUserInfo
	let type: SocialNetwork
	let id: String
	
	func toUserData() -> UserData {
		return UserData(userInfo: userInfo.toUserInfo())
	}
}

struct SocialUserInfo {
	let email: String
	let birthday: String
	let lastName: String
	let firstName: String
	let name: String
	let profilePic: String
	let gender: GenderType
	
	init(email: String = "", birthday: String = "", lastName: String = "", firstName: String = "", name: String = "", profilePic: String = "", gender: GenderType = .male) {
		self.email = email
		self.birthday = birthday
		self.lastName = lastName
		self.firstName = firstName
		self.name = name
		self.profilePic = profilePic
		self.gender = gender
	}
	
	func toUserInfo() -> UserInfoData {
		// -1 if never registerd before
		// Otherwise need to be update instead of register new
		return UserInfoData(nickName: name,
							email: email,
							birthday: birthday,
							avatar: profilePic,
							first_name: firstName,
							last_name: lastName)
	}
}
