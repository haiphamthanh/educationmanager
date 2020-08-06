//
//  PingAPI.swift
//  ASEducation
//
//  Created by HaiPT15 on 10/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import Moya

// MARK: - ================================= Path =================================
// C
// R
fileprivate let PATH_PING = "/ping" // Ping server
// U
// D

// MARK: - ================================= Params =================================
// Input
typealias InNWPing = Void

// MARK: - ================================= API Implement =================================
final class PingNetwork: BaseAPINetwork {
	private lazy var networkingVoid = Networking<PingAPI, VoidEntry>()
	
	func ping(input: InNWPing) -> OutNWBool {
		let api: PingAPI = .ping
		
		let result = networkingVoid.request(api)
		return OutNWBool(id, result)
	}
}

// Ping server to check connection
enum PingAPI {
	case ping
}

extension PingAPI : TargetType, APIType {
	var baseURL: URL {
		return URL(string: Server.shared.root)!
	}
	
	var path: String {
		switch self {
		case .ping:
			return PATH_PING
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .ping:
			return .get
		}
	}
	
	var task: Task {
		switch self {
		// Get
		case .ping:
			return .requestPlain
		}
	}
	
	var validate: Bool {
		return true
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var sampleData: Data {
		return "{}".data(using: .utf8)!
	}
	
	var addXAccess: Bool {
		return false
	}
}
