//
//  DeviceNetwork.swift
//  ASHManager
//
//  Created by KhoaLA on 4/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Moya
import RxSwift

final class DeviceNetwork: BaseAPINetwork {
	private let networkGobe = Network<GobeEntry, DeviceAPI>()
	private let networkFitbitToken = Network<FitbitEntry, DeviceAPI>()
	private let networkFitbit = Network<FitbitUser, DeviceAPI>()
	
	func fetchUserGobeData(userName: String, password: String) -> Observable<UserData> {
		let result: Observable<GobeEntry> = networkGobe.requestRx(api: .userGobeProfile(email: userName, password: password))
		return Observable.create({ observer -> Disposable in
			result.map({ user -> UserData in
				return user.toData()
			}).bind(to: observer)
		})
	}
	
	func fetchUserFitbitData(from code: String) -> Observable<UserData> {
		let fitbitData = fetchFitbitData(from: code)
		
		return fitbitData
			.flatMap { [weak self] fitbitData -> Observable<UserData> in
				let result: Observable<FitbitUser> = self?.networkFitbit.requestRx(api: .userFitbitProfile(token: fitbitData.access_token)) ?? Observable<FitbitUser>.never()
				
				return Observable.create({ observer -> Disposable in
					result.map({ user -> UserData in
						return user.info.toData()
					}).bind(to: observer)
				})
		}
	}
}

private extension DeviceNetwork {
	func fetchFitbitData(from code: String) -> Observable<FitbitData> {
		let result: Observable<FitbitEntry> = networkFitbitToken.requestRx(api: .fitbitData(fitbitCode: code, clientId: Config.fitbitClientID, directURL: Config.fitbitRedirectURI))
		return Observable.create({ observer -> Disposable in
			result.map({ user -> FitbitData in
				return user.toData()
			}).bind(to: observer)
		})
	}
}

enum DeviceAPI {
	case userGobeProfile(email: String, password: String)
	case userFitbitProfile(token: String)
	case fitbitData(fitbitCode: String, clientId: String, directURL: String)
}

extension DeviceAPI: TargetType {
	
	var baseURL: URL {
		switch self {
		case .userGobeProfile:
			return URL(string: "https://api.healbe.com/api")!
		case .userFitbitProfile:
			return URL(string: "https://api.fitbit.com/1/user/-/profile.json")!
		case .fitbitData:
			return URL(string: "https://api.fitbit.com/oauth2/token")!
		}
	}
	
	var path: String {
		switch self {
		case .userGobeProfile:
			return ""
		case .userFitbitProfile:
			return ""
		case .fitbitData:
			return ""
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .userGobeProfile, .userFitbitProfile:
			return .get
		case .fitbitData:
			return .post
		}
	}
	
	var sampleData: Data {
		return "{}".data(using: .utf8)!
	}
	
	var task: Task {
		switch self {
		case .userGobeProfile(let email, let password):
			return .requestParameters(parameters: ["request": 1, "email": email, "password": password],
									  encoding: URLEncoding.default)
		case .userFitbitProfile:
			return .requestParameters(parameters: ["":""],
									  encoding: URLEncoding.default)
		case .fitbitData(let fitbitCode, let clientId, let directURL):
			let params: [String: Any] = ["grant_type":"authorization_code",
										 "clientId": clientId,
										 "code": fitbitCode,
										 "redirect_uri": directURL]
			return .requestParameters(parameters: params,
									  encoding: URLEncoding.default)
		}
	}
	
	var validate: Bool {
		switch self {
		case .userGobeProfile(_, _):
			return true
		case .userFitbitProfile:
			return true
		case .fitbitData(_, _, _):
			return true
		}
	}
	
	var headers: [String : String]? {
		switch self {
		case .userGobeProfile(_, _):
			return ServerInfo.HEADER_SERVER_PARAMS
		case .userFitbitProfile(let token):
			return ["Authorization": "Bearer \(token)"]
		case .fitbitData(_, _, _):
			let data = "\(Config.fitbitClientID):\(Config.fitbitClientSecret)".data(using: .utf8)
			let base64 = data!.base64EncodedString()
			return ["Authorization": "Basic \(base64)"]
		}
	}
}
