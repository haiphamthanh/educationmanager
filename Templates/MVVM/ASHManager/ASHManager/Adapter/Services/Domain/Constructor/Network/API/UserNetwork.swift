//
//  UserNetwork.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import Moya

// MARK: - ================================= Path =================================
// C
fileprivate let PATH_USER_REGISTER = "/user/register" // Register new account
// R
fileprivate let PATH_USER_DETAIL = "/user/detail" // User detail
// U
fileprivate let PATH_USER_UPDATE_INFO = "/user/info" // Update info
fileprivate let PATH_USER_UPDATE_PASSWORD = "/user/password" // Update password

fileprivate let PATH_AUTH_RECOVER_REQUEST_PINCODE = "/user/request_pincode"
fileprivate let PATH_AUTH_RECOVER_RESET_PASS = "/user/recover_password"
// D

// MARK: - ================================= Params =================================
// Input
typealias InNWUserInfo = (Void)
typealias InNWUserInputPinCode = (String)
typealias InNWUserResetPassword = (resetCode: String, newPassword: String)
typealias InNWUserRegister = (user: UserData, avatar: Data?, password: String)
typealias InNWUserUpdate = (user: UserData, avatar: Data?, password: String)
typealias InNWUserChangePassword = (oldPassword: String, newPassword: String)

// MARK: - ================================= API Implement =================================
final class UserNetwork: BaseAPINetwork {
	private lazy var networking = Networking<UserAPI, UserEntry>()
	private lazy var networkingVoid = Networking<UserAPI, VoidEntry>()
	
	// GET
	func userInfo(input: InNWUserInfo) -> OutNWUserData {
		let api: UserAPI = .userInfo
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	// Recover password
	func requestPINCode(input: InNWUserInputPinCode) -> OutNWUserVoid {
		let api: UserAPI = .requestPINCode(email: input)
		
		let result = networkingVoid
			.request(id: id, api)
			.map(transformToVoid)
		
		return OutNWUserVoid(id, result)
	}
	
	func resetPassword(input: InNWUserResetPassword) -> OutNWUserVoid {
		let api: UserAPI = .resetPassword(resetCode: input.resetCode, newPassword: input.newPassword)
		
		let result = networkingVoid
			.request(id: id, api)
			.map(transformToVoid)
		
		return OutNWUserVoid(id, result)
	}
	
	// POST
	func register(input: InNWUserRegister) -> OutNWUserData {
		let api: UserAPI = .register(user: input.user, avatar: input.avatar, password: input.password)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	// PUT
	func update(input: InNWUserUpdate) -> OutNWUserData {
		let api: UserAPI = .update(user: input.user, avatar: input.avatar)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	func changePassword(input: InNWUserChangePassword) -> OutNWUserData {
		let api: UserAPI = .changePassword(oldPassword: input.oldPassword, newPassword: input.newPassword)
		
		let result = networking
			.request(id: id, api)
			.map(transformToData)
		
		return OutNWUserData(id, result)
	}
	
	private func transformToData(_ user: UserEntry) -> UserData {
		let userData = user.asData()
		return didSignIn(user: userData)
	}
}

// MARK: - ================================= API Interface =================================
enum UserAPI {
	// Get
	case userInfo
	case requestPINCode(email: String)
	case resetPassword(resetCode: String, newPassword: String)
	
	// Post
	case register(user: UserData, avatar: Data?, password: String)
	
	// Put
	case update(user: UserData, avatar: Data?)
	case changePassword(oldPassword: String, newPassword: String)
}

// MARK: - ================================= API Params =================================
extension UserAPI: TargetType, APIType {
	var baseURL: URL {
		return URL(string: Server.shared.root)!
	}
	
	var path: String {
		switch self {
		case .userInfo:
			return PATH_USER_DETAIL
		case.requestPINCode:
			return PATH_AUTH_RECOVER_REQUEST_PINCODE
		case .resetPassword:
			return PATH_AUTH_RECOVER_RESET_PASS
		case .register:
			return PATH_USER_REGISTER
		case .update:
			return PATH_USER_UPDATE_INFO
		case .changePassword:
			return PATH_USER_UPDATE_PASSWORD
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .userInfo, .requestPINCode, .resetPassword:
			return .get
		case .register:
			return .post
		case .update, .changePassword:
			return .put
		}
	}
	
	var task: Task {
		switch self {
		// Get
		case .userInfo:
			return .requestPlain
		case .requestPINCode(let email):
			return .requestParameters(parameters: ["email": email],
									  encoding: URLEncoding.default)
		case .resetPassword(let resetCode, let newPassword):
			return .requestParameters(parameters: ["code": resetCode,
												   "password": newPassword],
									  encoding: URLEncoding.default)
		// Post
		case .register(let user, let avatar, let password):
			return userTask(user: user, avatar: avatar, password: password)
			
		// Put
		case .update(let user, let avatar):
			return userTask(user: user, avatar: avatar)
		case .changePassword(let oldPassword, let newPassword):
			return .requestParameters(parameters: ["oldPassword": oldPassword,
												   "newPassword": newPassword],
									  encoding: URLEncoding.default)
		}
	}
	
	var validate: Bool {
		return true
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var sampleData: Data {
		return stubbedResponse("User")
	}
	
	var addXAccess: Bool {
		switch self {
		case .register,
			 .requestPINCode,
			 .resetPassword:
			return false
		default:
			return true
		}
	}
}

private extension UserAPI {
	func userTask(user: UserData, avatar: Data? = nil, password: String? = nil) -> Task {
		let userInfo = user.userInfo
		let health = user.health
		
		var params: [String : Any] = ["username" : userInfo.username,
									  "email" : userInfo.email,
									  "birthday" : userInfo.birthday,
									  "gender" : userInfo.gender.rawValue,
									  "first_name" : userInfo.first_name,
									  "last_name" : userInfo.last_name,
									  "height" : health.height,
									  "weight" : health.weight,
									  "blood_type" : health.blood_type,
									  "latitude" : userInfo.latitude,
									  "longitude" : userInfo.longitude,
									  "nick_name" : userInfo.nickName ?? ""]
		
		// Use for register
		if let password = password, !password.isEmpty {
			params["password"] = password
		}
		
		// Use for avatar update
		guard let avatar = avatar,
			let verifiedImage = UIImage(data: avatar),
			let scaledImageData = verifiedImage.jpegData(compressionQuality: 0.5) else {
				return .requestParameters(parameters: params, encoding: URLEncoding.default)
		}
		
		let mimeType = "image/jpg"
		let formData = [MultipartFormData(provider: .data(scaledImageData),
										  name: "newAvatar",
										  fileName: "newPhoto",
										  mimeType: mimeType)]
		return .uploadCompositeMultipart(formData, urlParameters: params)
	}
}
