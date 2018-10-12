//
//  UserNetwork.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import Moya
import CoreLocation

// MARK: - ================================= Path =================================
fileprivate let PATH_USER_DETAIL = "/user/detail"
fileprivate let PATH_USER_REGISTER = "/user/register"
fileprivate let PATH_USER_UPDATE_INFO = "/user/update"
fileprivate let PATH_USER_UPDATE_PASSWORD = "/user/password"
fileprivate let PATH_ENABLE_UPDATE_EMAIL = "/user/email/subscribe"
fileprivate let PATH_START_STOP_CHALLENGE = "/user_contest_challenge/start_stop"
fileprivate let PATH_CHALLENGE_RESULT = "/user_contest_challenge/%d/result"
fileprivate let PATH_CONTEST_JOIN = "contest/user/join"

fileprivate let PATH_HEALTH_PROFILE_ALL = "/health_profile/get"
fileprivate let PATH_HEALTH_PROFILE_LIST_DATE = "/health_profile/%@/list_date"
fileprivate let PATH_HEALTH_PROFILE_GET_DATE = "/health_profile/%@/get/%@/"
fileprivate let PATH_HEALTH_PROFILE_PUT_DATE = "/health_profile/%@/put/%@"
fileprivate let PATH_HEALTH_PROFILE_DELETE_DATE = "/health_profile/%@/delete/%@/"

final class UserNetwork: BaseAPINetwork {
	private let networkVoid = Network<VoidObject, UserAPI>()
	private let network = Network<UserEntry, UserAPI>()
	private let networkAuth = Network<AuthEntry, UserAPI>()
	
	func detailUser() -> Observable<UserData> {
		guard let token = token else {
			return Observable.never()
		}
		
		let result: Observable<UserEntry> = network.requestRx(api: .detailUser(token: token))
		
		return Observable.create({ observer -> Disposable in
			result.map({ user -> UserData in
				return user.toData()
			}).bind(to: observer)
		})
	}
	
	func updateUser(user: UserData) -> Observable<Void> {
		guard let token = token else {
			return Observable.never()
		}
		
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .updateUser(user: user, token: token))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
	
	func change(password: String, of userName: String) -> Observable<Void> {
		guard let token = token else {
			return Observable.never()
		}
		
		let result: Observable<VoidObject> = networkVoid.requestRx(api: .changePassword(password: password,
																						userName: userName,
																						token: token))
		
		return Observable.create({ observer -> Disposable in
			result.map({ result -> Void in }).bind(to: observer)
		})
	}
	
	func register(user: UserData) -> Observable<AuthData> {
		let result: Observable<AuthEntry> = networkAuth.requestBgRx(api: .register(user: user))
		return Observable.create({ observer -> Disposable in
			result.map({ auth -> AuthData in
				return auth.toData()
			}).bind(to: observer)
		})
	}
}

enum UserAPI {
	case detailUser(token: String)
	case register(user: UserData)
	case updateUser(user: UserData, token: String)
	case changePassword(password: String, userName: String, token: String)
}

extension UserAPI: TargetType {
	
	var baseURL: URL {
		return URL(string: ServerInfo.DATA_SERVER_ROOT_URL)!
	}
	
	var path: String {
		switch self {
		case .detailUser:
			return PATH_USER_DETAIL
		case .register:
			return PATH_USER_REGISTER
		case .updateUser(_, _):
			return PATH_USER_UPDATE_INFO
		case .changePassword:
			return PATH_USER_UPDATE_PASSWORD
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .register, .updateUser, .changePassword:
			return .post
		case .detailUser:
			return .get
		}
	}
	
	var sampleData: Data {
		return "{}".data(using: .utf8)!
	}
	
	var task: Task {
		switch self {
		case .detailUser(let token):
			return .requestParameters(parameters: ["token": token],
									  encoding: URLEncoding.default)
			
		case .register(let user):
			var imageData: Data? = nil
			var mimeType = "image/jpg"
			
			let userInfo = user.userInfo
			let health = user.health

			var param:  [String : Any] = ["username"			: userInfo.username,
										  "password"			: userInfo.password,
										  "email"				: userInfo.email,
										  "birthday"			: userInfo.birthday,
										  "gender"				: userInfo.gender.rawValue,
										  "first_name"			: userInfo.first_name,
										  "last_name"			: userInfo.last_name,
										  "height"				: health.height,
										  "height_type"			: health.height_type.rawValue,
										  "weight"				: health.weight,
										  "weight_type"			: health.weight_type.rawValue,
										  "blood_pressure_upper": health.blood_pressure_upper,
										  "blood_pressure_under": health.blood_pressure_under,
										  "blood_type"			: health.blood_type,
										  "surgery_status"		: health.surgery_status.rawValue,
										  "feel_condition"		: health.feel_condition.rawValue,
										  "smoking_level"		: health.smoking_frequency.rawValue,
										  "alcohol_level"		: health.alcohol_level.rawValue,
										  "latitude"			: "\(userInfo.latitude)",
										  "longitude"			: "\(userInfo.longitude)",
										  "gobe_username"		: health.gobe_username ?? "",
										  "gobe_password"		: health.gobe_password ?? "",
										  "fitbit_access_token"	: health.fitbit_access_token ?? "",
										  "fitbit_refresh_token": health.fitbit_refresh_token ?? "",
										  "fitbit_expires_in"	: health.fitbit_expires_in ?? 0,
										  "health_source"		: health.health_source.rawValue]
			
			if !userInfo.nickName!.isEmpty {
				param["nick_name"] = userInfo.nickName
			}
			
			param["drink_each_time"] = health.drink_frequency.rawValue
			param["smoking_each_time"] = health.smoking_frequency.rawValue
			
			if let data = userInfo.avatarData {
				if let image = UIImage(data: data) {
					// TODO: SCALE Image func later
					imageData = UIImageJPEGRepresentation(image, 0.5)!
					mimeType = "image/jpg"
					
					if let data = imageData {
						let formData = [MultipartFormData(provider: .data(data), name: "avatar", fileName: "photo.jpeg", mimeType: mimeType)]
						return .uploadCompositeMultipart(formData, urlParameters: param)
					}
				}
			}
			
			return .requestParameters(parameters: param,
									  encoding: URLEncoding.default)
			
			
		case .updateUser(let user, let token):
			var imageData = Data()
			var mimeType = "image/jpeg"
			
			let userInfo = user.userInfo
			let health = user.health
			var parameters: [String : Any] = ["email": userInfo.email,
											  "birthday": userInfo.birthday,
											  "gender": userInfo.gender.rawValue,
											  "first_name": userInfo.first_name,
											  "last_name": userInfo.last_name,
											  "height": health.height,
											  "height_type": health.height_type.rawValue,
											  "weight": health.weight,
											  "weight_type": health.weight_type.rawValue,
											  "surgery_status": health.surgery_status.rawValue,
											  "feel_condition": health.feel_condition.rawValue,
											  "smoking_level": health.smoking_frequency.rawValue,
											  "alcohol_level": health.alcohol_level.rawValue,
											  "blood_pressure_upper": health.blood_pressure_upper,
											  "blood_pressure_under": health.blood_pressure_under,
											  "blood_type": health.blood_type,
											  "latitude": userInfo.latitude,
											  "longitude": userInfo.longitude,
											  "nick_name": userInfo.nickName ?? "",
											  "gobe_username"		: health.gobe_username ?? "",
											  "gobe_password"		: health.gobe_password ?? "",
											  "fitbit_access_token"	: health.fitbit_access_token ?? "",
											  "fitbit_refresh_token": health.fitbit_refresh_token ?? "",
											  "fitbit_expires_in"	: health.fitbit_expires_in ?? 0,
											  "health_source"		: health.health_source.rawValue,
											  "token": token]
			
			parameters["drink_each_time"] = health.drink_frequency.rawValue
			parameters["smoking_each_time"] = health.smoking_frequency.rawValue
			
			if let data = userInfo.avatarData {
				if let image = UIImage(data: data) {
					// TODO: SCALE Image func later
					imageData = UIImageJPEGRepresentation(image, 0.5)!
					mimeType = "image/jpg"
				}
				
				let formData = [MultipartFormData(provider: .data(imageData), name: "avatar", fileName: "photo.jpg", mimeType: mimeType)]
				return .uploadCompositeMultipart(formData, urlParameters: parameters)
			}
			
			return .requestParameters(parameters: parameters,
									  encoding: URLEncoding.default)
			
		case .changePassword(let password, let username, let token):
			return .requestParameters(parameters: ["username": username,
												   "password": password,
												   "token": token],
									  encoding: URLEncoding.default)
		}
	}
	
	var validate: Bool {
		return true
	}
	
	var headers: [String : String]? {
		return ServerInfo.HEADER_SERVER_PARAMS
	}
}
