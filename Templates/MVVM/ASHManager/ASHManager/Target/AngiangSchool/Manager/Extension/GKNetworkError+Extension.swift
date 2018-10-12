//
//  GKNetworkError+Extension.swift
//  ASHManager
//
//  Created by HaiPT15 on 5/30/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

enum GKNetworkErrorCode: String {
	// MARK: -------------------------------- Common message --------------------------------
	case C_E_004 = "C_E_004"
	case C_E_005 = "C_E_005"
	case C_E_006 = "C_E_006"

	// MARK: -------------------------------- /api/v1/login --------------------------------
	case Login_001_E_001 = "Login_001_E_001"
	case Login_001_E_002 = "Login_001_E_002"
	case Login_001_E_003 = "Login_001_E_003"
	case Login_001_E_004 = "Login_001_E_004"
	case Login_001_E_005 = "Login_001_E_005"
	case Login_001_E_006 = "Login_001_E_006"
	case Login_001_E_007 = "Login_001_E_007"
	case Login_001_E_008 = "Login_001_E_008"
	case Login_001_E_009 = "Login_001_E_009"
	case Login_001_E_010 = "Login_001_E_010"
	case Login_001_E_011 = "Login_001_E_011"
	case Login_001_E_012 = "Login_001_E_012"
	case Login_001_E_013 = "Login_001_E_013"
	case Login_001_E_014 = "Login_001_E_014"
	case Login_001_E_015 = "Login_001_E_015"

	// MARK: -------------------------------- /api/v1/user/register --------------------------------
	case RegisterUser_001_E_001 = "RegisterUser_001_E_001"
	case RegisterUser_001_E_002 = "RegisterUser_001_E_002"
	case RegisterUser_001_E_003 = "RegisterUser_001_E_003"
	case RegisterUser_001_E_004 = "RegisterUser_001_E_004"
	case RegisterUser_001_E_005 = "RegisterUser_001_E_005"
	case RegisterUser_001_E_006 = "RegisterUser_001_E_006"
	case RegisterUser_001_E_007 = "RegisterUser_001_E_007"
	case RegisterUser_001_E_008 = "RegisterUser_001_E_008"
	case RegisterUser_001_E_009 = "RegisterUser_001_E_009"
	case RegisterUser_001_E_010 = "RegisterUser_001_E_010"
	case RegisterUser_001_E_043 = "RegisterUser_001_E_043"
	case RegisterUser_001_E_011 = "RegisterUser_001_E_011"
	case RegisterUser_001_E_044 = "RegisterUser_001_E_044"
	case RegisterUser_001_E_014 = "RegisterUser_001_E_014"
	case RegisterUser_001_E_015 = "RegisterUser_001_E_015"
	case RegisterUser_001_E_016 = "RegisterUser_001_E_016"
	case RegisterUser_001_E_017 = "RegisterUser_001_E_017"
	case RegisterUser_001_E_022 = "RegisterUser_001_E_022"
	case RegisterUser_001_E_057 = "RegisterUser_001_E_057"
	case RegisterUser_001_E_058 = "RegisterUser_001_E_058"
	case RegisterUser_001_E_047 = "RegisterUser_001_E_047"
	case RegisterUser_001_E_048 = "RegisterUser_001_E_048"
	case RegisterUser_001_E_059 = "RegisterUser_001_E_059"
	case RegisterUser_001_E_061 = "RegisterUser_001_E_061"
	case RegisterUser_001_E_041 = "RegisterUser_001_E_041"
	case RegisterUser_001_E_042 = "RegisterUser_001_E_042"
	case RegisterUser_001_E_055 = "RegisterUser_001_E_055"
	case RegisterUser_001_E_056 = "RegisterUser_001_E_056"
	case RegisterUser_001_E_068 = "RegisterUser_001_E_068"
	case RegisterUser_001_E_069 = "RegisterUser_001_E_069"
	case RegisterUser_001_E_081 = "RegisterUser_001_E_081"

	// MARK: -------------------------------- /api/v1/user/update --------------------------------
	case UpdateUser_001_E_001 = "UpdateUser_001_E_001"
	case UpdateUser_001_E_002 = "UpdateUser_001_E_002"
	case UpdateUser_001_E_003 = "UpdateUser_001_E_003"
	case UpdateUser_001_E_004 = "UpdateUser_001_E_004"
	case UpdateUser_001_E_007 = "UpdateUser_001_E_007"
	case UpdateUser_001_E_008 = "UpdateUser_001_E_008"
	case UpdateUser_001_E_009 = "UpdateUser_001_E_009"
	case UpdateUser_001_E_010 = "UpdateUser_001_E_010"
	case UpdateUser_001_E_011 = "UpdateUser_001_E_011"
	case UpdateUser_001_E_013 = "UpdateUser_001_E_013"
	case UpdateUser_001_E_045 = "UpdateUser_001_E_045"
	case UpdateUser_001_E_046 = "UpdateUser_001_E_046"
	case UpdateUser_001_E_036 = "UpdateUser_001_E_036"
	case UpdateUser_001_E_037 = "UpdateUser_001_E_037"
	case UpdateUser_001_E_047 = "UpdateUser_001_E_047"
	case UpdateUser_001_E_049 = "UpdateUser_001_E_049"
	case UpdateUser_001_E_030 = "UpdateUser_001_E_030"
	case UpdateUser_001_E_044 = "UpdateUser_001_E_044"
	case UpdateUser_001_E_072 = "UpdateUser_001_E_072"
	
	// MARK: -------------------------------- /api/v1/user/detail --------------------------------
	case GetUserInformationService_Err_01 = "GetUserInformationService_Err_01"

	// MARK: -------------------------------- /api/v1/user/password --------------------------------
	case UpdatePassword_001_E_001 = "UpdatePassword_001_E_001"
	case UpdatePassword_001_E_002 = "UpdatePassword_001_E_002"
	case UpdatePassword_001_E_003 = "UpdatePassword_001_E_003"
	case UpdatePassword_001_E_004 = "UpdatePassword_001_E_004"
	case UpdatePassword_001_E_005 = "UpdatePassword_001_E_005"
	case UpdatePassword_001_E_006 = "UpdatePassword_001_E_006"
	case UpdatePassword_001_E_007 = "UpdatePassword_001_E_007"
	case UpdatePassword_001_E_008 = "UpdatePassword_001_E_008"

	// MARK: -------------------------------- /api/v1/user/forgot_password --------------------------------
	case SendCodePassword_001_E_001 = "SendCodePassword_001_E_001"
	case SendCodePassword_001_E_004 = "SendCodePassword_001_E_004"
	case SendCodePassword_001_E_005 = "SendCodePassword_001_E_005"

	// MARK: -------------------------------- /api/v1/user/active_password --------------------------------
	case RecoverPassword_001_E_001 = "RecoverPassword_001_E_001"
	case RecoverPassword_001_E_002 = "RecoverPassword_001_E_002"
	case RecoverPassword_001_E_003 = "RecoverPassword_001_E_003"
	case RecoverPassword_001_E_004 = "RecoverPassword_001_E_004"
	case RecoverPassword_001_E_007 = "RecoverPassword_001_E_007"
	case RecoverPassword_001_E_008 = "RecoverPassword_001_E_008"

	// MARK: -------------------------------- /api/v1/login_google --------------------------------
	// MARK: -------------------------------- /api/v1/login_facebook --------------------------------
	// MARK: -------------------------------- /api/v1/logout --------------------------------
	// MARK: -------------------------------- /api/v1/be_ecommerce/login --------------------------------
	case Login_Ecommerce_Err_001 = "Login_Ecommerce_Err_001"
	case Login_Ecommerce_Err_002 = "Login_Ecommerce_Err_002"
	case Login_Ecommerce_Err_003 = "Login_Ecommerce_Err_003"
	case Login_Ecommerce_Err_004 = "Login_Ecommerce_Err_004"
	case Login_Ecommerce_Err_006 = "Login_Ecommerce_Err_006"
	case Login_Ecommerce_Err_007 = "Login_Ecommerce_Err_007"
	case Login_Ecommerce_Err_008 = "Login_Ecommerce_Err_008"
	case LoginFB_001_E_001 = "LoginFB_001_E_001"
	case LoginGG_001_E_001 = "LoginGoogle_001_E_001"
	
	// MARK: -------------------------------- /api/v1/contest/user/join --------------------------------
	case Join_Contest_001_E_006 = "JoinContest_001_E_006"
	case Join_Contest_001_E_007 = "JoinContest_001_E_007"
	case Join_Contest_001_E_008 = "JoinContest_001_E_008"
	case Join_Contest_001_E_009 = "JoinContest_001_E_009"
	case Join_Contest_001_E_010 = "JoinContest_001_E_010"
	case Join_Contest_001_E_012 = "JoinContest_001_E_012"
	case Join_Contest_001_E_013 = "JoinContest_001_E_013"
	case Join_Contest_001_E_014 = "JoinContest_001_E_014"
	case Join_Contest_001_E_015 = "JoinContest_001_E_015"
	case Join_Contest_001_E_016 = "JoinContest_001_E_016"
	// MARK: -------------------------------- /api/v1/user_contest_challenge/start_stop --------------------------------
	case StartStopChallenge_001_E_002 = "StartStopChallenge_001_E_002"
	case StartStopChallenge_001_E_005 = "StartStopChallenge_001_E_005"
	case StartStopChallenge_001_E_006 = "StartStopChallenge_001_E_006"
	case StartStopChallenge_001_E_011 = "StartStopChallenge_001_E_011"
	case StartStopChallenge_001_E_012 = "StartStopChallenge_001_E_012" 
	
	case Undefine_Error = "Undefine_Error"
	
	init(rawValueOnOption: String) {
		if let value = GKNetworkErrorCode(rawValue: rawValueOnOption) {
			self = value
		} else {
			self = .Undefine_Error
		}
	}
}
