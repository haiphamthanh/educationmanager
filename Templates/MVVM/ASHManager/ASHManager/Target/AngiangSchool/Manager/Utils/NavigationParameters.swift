//
//  Constant.swift
//  ASHManager
//
//  Created by PhanDuyHai on 1/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class NavigationParameters {
	static let KeyAuthentication = "authentication"
	static let KeyPrivicyPolicy = "privicyPolicy"
	static let KeyRecoverPasswordEmail = "recoverPasswordEmail"
	static let KeyUserUpdating = "keyUserUpdating"
	//============================= Present or push view ==============================================================
	static func set(dontWantToBack: Bool, to params: inout Dictionary<String, Any>) {
		params[KeyAuthentication] = dontWantToBack
	}
	
	static func getDontWantToBack(from params: Dictionary<String, Any>) -> Bool? {
		if params.keys.contains(KeyAuthentication), let value = params[KeyAuthentication] as? Bool {
			return value
		}
		
		return nil
	}
	
	//============================= Term Of Use ==============================================================
	static func setTermOfUseFor(params: inout Dictionary<String, Any>, viewType: TermOfUseViewType) {
		params[KeyPrivicyPolicy] = viewType
	}
	
	static func getTermOfUseFor(params: Dictionary<String, Any>) -> TermOfUseViewType? {
		if params.keys.contains(KeyPrivicyPolicy), let value = params[KeyPrivicyPolicy] as? TermOfUseViewType {
			return value
		}
		
		return nil
	}
	
	//============================= Recover Password ==========================================================
	static func setRecoverPasswordEmailFor(params: inout Dictionary<String, Any>, email: String) {
		params[KeyRecoverPasswordEmail] = email
	}
	
	static func getRecoverPasswordEmailFor(params: Dictionary<String, Any>) -> String? {
		if params.keys.contains(KeyRecoverPasswordEmail), let value = params[KeyRecoverPasswordEmail] as? String {
			return value
		}
		
		return nil
	}
	
	static func setUserUpdating(params: inout Dictionary<String, Any>, item: UserData) {
		params[KeyUserUpdating] = item
	}
	
	static func getUserUpdating(params: Dictionary<String, Any>) -> UserData? {
		if params.keys.contains(KeyUserUpdating), let value = params[KeyUserUpdating] as? UserData {
			return value
		}
		
		return nil
	}
}
