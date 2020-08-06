//
//  NavigationParameters.swift
//  ASHManager
//
//  Created by PhanDuyHai on 1/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

class NavigationParameters {
	private static let KeyTermOfUse 			= "NavigationParametersTermOfUse"
	private static let KeyRecoverPasswordEmail 	= "NavigationParametersRecoverPasswordEmail"
	private static let KeyUserData				= "NavigationParametersUserData"
	
	//============================= Term Of Use =======================================
	static func push(term: TermOfUseViewType, to params: inout Dictionary<String, Any>) {
		params[KeyTermOfUse] = term
	}
	
	static func popTerm(from params: Dictionary<String, Any>) -> TermOfUseViewType? {
		return params[KeyTermOfUse] as? TermOfUseViewType ?? nil
	}
	
	//============================= Recover Password ===================================
	static func push(email: String, to params: inout Dictionary<String, Any>) {
		params[KeyRecoverPasswordEmail] = email
	}
	
	static func popEmail(from params: Dictionary<String, Any>) -> String? {
		return params[KeyRecoverPasswordEmail] as? String ?? nil
	}
	
	//============================= User ===================================
	static func push(user: UserData, to params: inout Dictionary<String, Any>) {
		params[KeyUserData] = user
	}
	
	static func popUser(from params: Dictionary<String, Any>) -> UserData? {
		return params[KeyUserData] as? UserData ?? nil
	}
}
