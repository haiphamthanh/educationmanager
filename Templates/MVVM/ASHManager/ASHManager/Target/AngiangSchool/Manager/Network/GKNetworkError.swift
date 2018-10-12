//
//  GKNetworkError.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

struct GKError {
	var networkError: GKNetworkError?
	var gkResponseError: [GKResponseError]
	
	init(networkError: GKNetworkError? = nil, response: Response? = nil) {
		self.networkError = networkError
		self.gkResponseError = []
		self.gkResponseError = convertResponseError(response: response)
	}
	
	func convertResponseError(response: Response?) -> [GKResponseError] {
		// Got response - check response Data
		if let responseData = response {
			let string = String(data: responseData.data, encoding: String.Encoding.utf8)
			do {
				let responseObject: ResponseObject = try Mapper<ResponseObject>().map(JSONString: string!)
				responseObject.handleWithStatusCode()
				if let arrayError = responseObject.arrayError {
					var array = [GKResponseError]()
					for error in arrayError {
						let errorCode = GKNetworkErrorCode(rawValueOnOption: error)
						let gkResponseError = GKResponseError(errorCode: errorCode)
						array.append(gkResponseError)
					}
					
					return array
				}
			} catch {
				
			}
		}
		return []
	}
}

enum GKResponseError: Error, LocalizedError {
	// MARK: -------------------------------- Common message --------------------------------
	case TokenExpire
	case TokenInvalid
	case TokenRequired
	
	// MARK: -------------------------------- /api/v1/login --------------------------------
	case LoginUserNameRequired
	case LoginPasswordRequired
	case LoginInputIncorrectV1
	case LoginInputIncorrectV2
	case LoginInputEmpty
	
	// MARK: -------------------------------- /api/v1/user/register --------------------------------
	case RegisterUserRequired
	case RegisterUserLengh
	case RegisterUserLenghBetween
	case RegisterUserLatin
	case RegisterPassRequired
	case RegisterPassLengh
	case RegisterPassLenghBetween
	case RegisterEmailRequired
	case RegisterEmailFormat
	case RegisterEmailLenghBetween
	case RegisterOldUnderV1
	case RegisterDateFormat
	case RegisterImageFormat
	case RegisterImageSize
	case RegisterFirstNameLengh
	case RegisterLastNameLengh
	case RegisterHeighRequired
	case RegisterWeighRequired
	case RegisterGobeUserRequired
	case RegisterGobePassRequired
	case RegisterNickNameLengh
	case RegisterNickNameLenghBetween
	case RegisterHealthSourceRequired
	case RegisterFitbitTokenRequired
	case RegisterUserAvailable
	case RegisterEmailAvailable
	case RegisterOldUnderV2
	case RegisterSentError
	case RegisterHeighLessZero
	case RegisterWeighLessZero
	case RegisterBloodPressureConfict
	
	// MARK: -------------------------------- /api/v1/user/update --------------------------------
	case UpdateUserEmailFormat
	case UpdateUserEmailLenghBetween
	case UpdateUserDateFormat
	case UpdateUserOldUnderV1
	case UpdateUserImageSize
	case UpdateUserImageFormat
	case UpdateUserFirstNameLengh
	case UpdateUserLastNameLengh
	case UpdateUserHeigh
	case UpdateUserWeigh
	case UpdateUserGobeUserRequired
	case UpdateUserGobePassRequired
	case UpdateUserNickNameLengh
	case UpdateUserAddressLenghBetween
	case UpdateUserFitbitTokenRequired
	case UpdateUserHealthSourceRequired
	case UpdateUserAvailable
	case UpdateUserOldUnderV2
	case UpdateUserEmailExist
	
	// MARK: -------------------------------- /api/v1/user/detail --------------------------------
	case GetUserNameNotExist
	
	// MARK: -------------------------------- /api/v1/user/password --------------------------------
	case UpdatePassRequired
	case UpdatePassLengh
	case UpdatePassLenghBetween
	case UpdateCurrentPassRequired
	case UpdateNewPassLengh
	case UpdateNewPassLenghBetween
	case UpdatePassDupplicate
	case UpdatePassIncorrect
	
	// MARK: -------------------------------- /api/v1/user/forgot_password --------------------------------
	case SendCodeEmailRequired
	case SendCodeEmailNotExists
	case SendCodeSentError
	
	// MARK: -------------------------------- /api/v1/user/active_password --------------------------------
	case RecoverPassRequired
	case RecoverPassLengh
	case RecoverPassLenghBetween
	case RecoverPassActiveCodeRequired
	case RecoverPassUserNotExists
	case RecoverPassActiveCodeNotExists
	
	// MARK: -------------------------------- /api/v1/login_google --------------------------------
	// MARK: -------------------------------- /api/v1/login_facebook --------------------------------
	// MARK: -------------------------------- /api/v1/logout --------------------------------
	// MARK: -------------------------------- /api/v1/be_ecommerce/login --------------------------------
	case LoginEcoUserRequired
	case LoginEcoUserLengh
	case LoginEcoUserLenghBetween
	case LoginEcoUserLatin
	case LoginEcoPassRequired
	case LoginEcoPassLengh
	case LoginEcoPassLenghBetween
	case Facebook_Error_001
	case Google_Error_001
	// MARK: -------------------------------- /api/v1/contest/user/join --------------------------------
	case JoinContestPeriodTime
	case JoinContestAlreadyJoined
	case JoinContestNotInProgram
	case JoinContestMembershipType
	case JoinContestGender
	case JoinContestAge
	case JoinContestBMI
	case JoinContestDrinkingHabit
	case JoinContestSmokingHabit
	case JoinContestHealthSource
	// MARK: -------------------------------- /api/v1/user_contest_challenge/start_stop --------------------------------
	case StartStopChallengeUserNotJoin
	case StartStopChallengeIDNotExistInDatabase
	case StartStopChallengeNotInContest
	case StartStopChallengeContestNotExist
	case StartStopChallengePlayingOtherContest
	
	case Undefine_Error
	
	init(errorCode: GKNetworkErrorCode) {
		switch errorCode {
		// MARK: -------------------------------- Common message --------------------------------
		case .C_E_004:
			self = .TokenExpire
		case .C_E_005:
			self = .TokenInvalid
		case .C_E_006:
			self = .TokenRequired
		// MARK: -------------------------------- /api/v1/login --------------------------------
		case .Login_001_E_001,
			 .Login_001_E_002,
			 .Login_001_E_003,
			 .Login_001_E_004,
			 .Login_001_E_006,
			 .Login_001_E_007,
			 .Login_001_E_008,
			 .Login_001_E_009,
			 .Login_001_E_010,
			 .Login_001_E_011,
			 .Login_001_E_012,
			 .Login_001_E_014,
			 .Login_001_E_015:
			self = .LoginInputIncorrectV1
		case .Login_001_E_005:
			self = .LoginPasswordRequired
		case .Login_001_E_013:
			self = .LoginInputEmpty
		// MARK: -------------------------------- /api/v1/user/register --------------------------------
		case .RegisterUser_001_E_001:
			self = .RegisterUserRequired
		case .RegisterUser_001_E_002:
			self = .RegisterUserLengh
		case .RegisterUser_001_E_003:
			self = .RegisterUserLenghBetween
		case .RegisterUser_001_E_004:
			self = .RegisterUserLatin
		case .RegisterUser_001_E_005:
			self = .RegisterPassRequired
		case .RegisterUser_001_E_006:
			self = .RegisterPassLengh
		case .RegisterUser_001_E_007:
			self = .RegisterPassLenghBetween
		case .RegisterUser_001_E_008:
			self = .RegisterEmailRequired
		case .RegisterUser_001_E_009:
			self = .RegisterEmailFormat
		case .RegisterUser_001_E_010:
			self = .RegisterEmailLenghBetween
		case .RegisterUser_001_E_043:
			self = .RegisterOldUnderV1
		case .RegisterUser_001_E_011:
			self = .RegisterDateFormat
		case .RegisterUser_001_E_044:
			self = .RegisterImageFormat
		case .RegisterUser_001_E_014:
			self = .RegisterImageSize
		case .RegisterUser_001_E_015:
			self = .RegisterFirstNameLengh
		case .RegisterUser_001_E_016:
			self = .RegisterLastNameLengh
		case .RegisterUser_001_E_017:
			self = .RegisterHeighRequired
		case .RegisterUser_001_E_022:
			self = .RegisterWeighRequired
		case .RegisterUser_001_E_057:
			self = .RegisterGobeUserRequired
		case .RegisterUser_001_E_058:
			self = .RegisterGobePassRequired
		case .RegisterUser_001_E_047:
			self = .RegisterNickNameLengh
		case .RegisterUser_001_E_048:
			self = .RegisterNickNameLenghBetween
		case .RegisterUser_001_E_059:
			self = .RegisterHealthSourceRequired
		case .RegisterUser_001_E_061:
			self = .RegisterFitbitTokenRequired
		case .RegisterUser_001_E_041:
			self = .RegisterUserAvailable
		case .RegisterUser_001_E_042:
			self = .RegisterEmailAvailable
		case .RegisterUser_001_E_055:
			self = .RegisterOldUnderV2
		case .RegisterUser_001_E_056:
			self = .RegisterSentError
		case .RegisterUser_001_E_068:
			self = .RegisterHeighLessZero
		case .RegisterUser_001_E_069:
			self = .RegisterWeighLessZero
		case .RegisterUser_001_E_081:
			self = .RegisterBloodPressureConfict
		// MARK: -------------------------------- /api/v1/user/update --------------------------------
		case .UpdateUser_001_E_001:
			self = .UpdateUserEmailFormat
		case .UpdateUser_001_E_002:
			self = .UpdateUserEmailLenghBetween
		case .UpdateUser_001_E_003:
			self = .UpdateUserDateFormat
		case .UpdateUser_001_E_004:
			self = .UpdateUserOldUnderV1
		case .UpdateUser_001_E_007:
			self = .UpdateUserImageSize
		case .UpdateUser_001_E_008:
			self = .UpdateUserImageFormat
		case .UpdateUser_001_E_009:
			self = .UpdateUserFirstNameLengh
		case .UpdateUser_001_E_010:
			self = .UpdateUserLastNameLengh
		case .UpdateUser_001_E_011:
			self = .UpdateUserHeigh
		case .UpdateUser_001_E_013:
			self = .UpdateUserWeigh
		case .UpdateUser_001_E_045:
			self = .UpdateUserGobeUserRequired
		case .UpdateUser_001_E_046:
			self = .UpdateUserGobePassRequired
		case .UpdateUser_001_E_036:
			self = .UpdateUserNickNameLengh
		case .UpdateUser_001_E_037:
			self = .UpdateUserAddressLenghBetween
		case .UpdateUser_001_E_047:
			self = .UpdateUserFitbitTokenRequired
		case .UpdateUser_001_E_049:
			self = .UpdateUserHealthSourceRequired
		case .UpdateUser_001_E_030:
			self = .UpdateUserAvailable
		case .UpdateUser_001_E_044:
			self = .UpdateUserOldUnderV2
		case .UpdateUser_001_E_072:
			self = .UpdateUserEmailExist
		// MARK: -------------------------------- /api/v1/user/detail --------------------------------
		case .GetUserInformationService_Err_01:
			self = .GetUserNameNotExist
		// MARK: -------------------------------- /api/v1/user/password --------------------------------
		case .UpdatePassword_001_E_001:
			self = .UpdatePassRequired
		case .UpdatePassword_001_E_002:
			self = .UpdatePassLengh
		case .UpdatePassword_001_E_003:
			self = .UpdatePassLenghBetween
		case .UpdatePassword_001_E_004:
			self = .UpdateCurrentPassRequired
		case .UpdatePassword_001_E_005:
			self = .UpdateNewPassLengh
		case .UpdatePassword_001_E_006:
			self = .UpdateNewPassLenghBetween
		case .UpdatePassword_001_E_007:
			self = .UpdatePassDupplicate
		case .UpdatePassword_001_E_008:
			self = .UpdatePassIncorrect
		// MARK: -------------------------------- /api/v1/user/forgot_password --------------------------------
		case .SendCodePassword_001_E_001:
			self = .SendCodeEmailRequired
		case .SendCodePassword_001_E_004:
			self = .SendCodeEmailNotExists
		case .SendCodePassword_001_E_005:
			self = .SendCodeSentError
		// MARK: -------------------------------- /api/v1/user/active_password --------------------------------
		case .RecoverPassword_001_E_001:
			self = .RecoverPassRequired
		case .RecoverPassword_001_E_002:
			self = .RecoverPassLengh
		case .RecoverPassword_001_E_003:
			self = .RecoverPassLenghBetween
		case .RecoverPassword_001_E_004:
			self = .RecoverPassActiveCodeRequired
		case .RecoverPassword_001_E_007:
			self = .RecoverPassUserNotExists
		case .RecoverPassword_001_E_008:
			self = .RecoverPassActiveCodeNotExists
		// MARK: -------------------------------- /api/v1/login_google --------------------------------
		// MARK: -------------------------------- /api/v1/login_facebook --------------------------------
		// MARK: -------------------------------- /api/v1/logout --------------------------------
		// MARK: -------------------------------- /api/v1/be_ecommerce/login --------------------------------
		case .Login_Ecommerce_Err_001:
			self = .LoginEcoUserRequired
		case .Login_Ecommerce_Err_002:
			self = .LoginEcoUserLengh
		case .Login_Ecommerce_Err_003:
			self = .LoginEcoUserLenghBetween
		case .Login_Ecommerce_Err_004:
			self = .LoginEcoUserLatin
		case .Login_Ecommerce_Err_006:
			self = .LoginEcoPassRequired
		case .Login_Ecommerce_Err_007:
			self = .LoginEcoPassLengh
		case .Login_Ecommerce_Err_008:
			self = .LoginEcoPassLenghBetween
		case .LoginFB_001_E_001:
			self = .Facebook_Error_001
		case .LoginGG_001_E_001:
			self = .Google_Error_001
		// MARK: -------------------------------- /api/v1/contest/user/join --------------------------------
		case .Join_Contest_001_E_006:
			self = .JoinContestPeriodTime
		case .Join_Contest_001_E_007:
			self = .JoinContestAlreadyJoined
		case .Join_Contest_001_E_008:
			self = .JoinContestNotInProgram
		case .Join_Contest_001_E_009:
			self = .JoinContestMembershipType
		case .Join_Contest_001_E_010:
			self = .JoinContestGender
		case .Join_Contest_001_E_012:
			self = .JoinContestAge
		case .Join_Contest_001_E_013:
			self = .JoinContestBMI
		case .Join_Contest_001_E_014:
			self = .JoinContestDrinkingHabit
		case .Join_Contest_001_E_015:
			self = .JoinContestSmokingHabit
		case .Join_Contest_001_E_016:
			self = .JoinContestHealthSource
		// MARK: -------------------------------- /api/v1/user_contest_challenge/start_stop --------------------------------
		case .StartStopChallenge_001_E_002:
			self = .StartStopChallengeUserNotJoin
		case .StartStopChallenge_001_E_005:
			self = .StartStopChallengeIDNotExistInDatabase
		case .StartStopChallenge_001_E_006:
			self = .StartStopChallengeNotInContest
		case .StartStopChallenge_001_E_011:
			self = .StartStopChallengeContestNotExist
		case .StartStopChallenge_001_E_012:
			self = .StartStopChallengePlayingOtherContest
			
		case .Undefine_Error:
			self = .Undefine_Error
		}
	}
	
	var errorDescription: String? {
		switch self {
		// MARK: -------------------------------- Common message --------------------------------
		case .TokenExpire:
			return LocalizedString.networkErrTokenExpire()
		case .TokenInvalid:
			return LocalizedString.networkErrTokenInvalid()
		case .TokenRequired:
			return LocalizedString.networkErrTokenRequired()
		// MARK: -------------------------------- /api/v1/login --------------------------------
		case .LoginUserNameRequired:
			return LocalizedString.networkErrLoginUserNameRequired()
		case .LoginPasswordRequired:
			return LocalizedString.networkErrLoginPasswordRequired()
		case .LoginInputIncorrectV1:
			return LocalizedString.networkErrLoginInputIncorrectV1()
		case .LoginInputIncorrectV2:
			return LocalizedString.networkErrLoginInputIncorrectV2()
		case .LoginInputEmpty:
			return LocalizedString.networkErrLoginInputEmpty()
		// MARK: -------------------------------- /api/v1/user/register --------------------------------
		case .RegisterUserRequired:
			return LocalizedString.networkErrRegisterUserRequired()
		case .RegisterUserLengh:
			return LocalizedString.networkErrRegisterUserLengh()
		case .RegisterUserLenghBetween:
			return LocalizedString.networkErrRegisterUserLenghBetween()
		case .RegisterUserLatin:
			return LocalizedString.networkErrRegisterUserLatin()
		case .RegisterPassRequired:
			return LocalizedString.networkErrRegisterPassRequired()
		case .RegisterPassLengh:
			return LocalizedString.networkErrRegisterPassLengh()
		case .RegisterPassLenghBetween:
			return LocalizedString.networkErrRegisterPassLenghBetween()
		case .RegisterEmailRequired:
			return LocalizedString.networkErrRegisterEmailRequired()
		case .RegisterEmailFormat:
			return LocalizedString.networkErrRegisterEmailFormat()
		case .RegisterEmailLenghBetween:
			return LocalizedString.networkErrRegisterEmailLenghBetween()
		case .RegisterOldUnderV1:
			return LocalizedString.networkErrRegisterOldUnderV1()
		case .RegisterDateFormat:
			return LocalizedString.networkErrRegisterDateFormat()
		case .RegisterImageFormat:
			return LocalizedString.networkErrRegisterImageFormat()
		case .RegisterImageSize:
			return LocalizedString.networkErrRegisterImageSize()
		case .RegisterFirstNameLengh:
			return LocalizedString.networkErrRegisterFirstNameLengh()
		case .RegisterLastNameLengh:
			return LocalizedString.networkErrRegisterLastNameLengh()
		case .RegisterHeighRequired:
			return LocalizedString.networkErrRegisterHeighRequired()
		case .RegisterWeighRequired:
			return LocalizedString.networkErrRegisterWeighRequired()
		case .RegisterGobeUserRequired:
			return LocalizedString.networkErrRegisterGobeUserRequired()
		case .RegisterGobePassRequired:
			return LocalizedString.networkErrRegisterGobePassRequired()
		case .RegisterNickNameLengh:
			return LocalizedString.networkErrRegisterNickNameLengh()
		case .RegisterNickNameLenghBetween:
			return LocalizedString.networkErrRegisterNickNameLenghBetween()
		case .RegisterHealthSourceRequired:
			return LocalizedString.networkErrRegisterHealthSourceRequired()
		case .RegisterFitbitTokenRequired:
			return LocalizedString.networkErrRegisterFitbitTokenRequired()
		case .RegisterUserAvailable:
			return LocalizedString.networkErrRegisterUserAvailable()
		case .RegisterEmailAvailable:
			return LocalizedString.networkErrRegisterEmailAvailable()
		case .RegisterOldUnderV2:
			return LocalizedString.networkErrRegisterOldUnderV2()
		case .RegisterSentError:
			return LocalizedString.networkErrRegisterSentError()
		case .RegisterHeighLessZero:
			return LocalizedString.networkErrRegisterHeighLessZero()
		case .RegisterWeighLessZero:
			return LocalizedString.networkErrRegisterWeighLessZero()
		case .RegisterBloodPressureConfict:
			return LocalizedString.networkErrRegisterBloodPressureConfict()
		// MARK: -------------------------------- /api/v1/user/update --------------------------------
		case .UpdateUserEmailFormat:
			return LocalizedString.networkErrUpdateUserEmailFormat()
		case .UpdateUserEmailLenghBetween:
			return LocalizedString.networkErrUpdateUserEmailLenghBetween()
		case .UpdateUserDateFormat:
			return LocalizedString.networkErrUpdateUserDateFormat()
		case .UpdateUserOldUnderV1:
			return LocalizedString.networkErrUpdateUserOldUnderV1()
		case .UpdateUserImageSize:
			return LocalizedString.networkErrUpdateUserImageSize()
		case .UpdateUserImageFormat:
			return LocalizedString.networkErrUpdateUserImageFormat()
		case .UpdateUserFirstNameLengh:
			return LocalizedString.networkErrUpdateUserFirstNameLengh()
		case .UpdateUserLastNameLengh:
			return LocalizedString.networkErrUpdateUserLastNameLengh()
		case .UpdateUserHeigh:
			return LocalizedString.networkErrUpdateUserHeigh()
		case .UpdateUserWeigh:
			return LocalizedString.networkErrUpdateUserWeigh()
		case .UpdateUserGobeUserRequired:
			return LocalizedString.networkErrUpdateUserGobeUserRequired()
		case .UpdateUserGobePassRequired:
			return LocalizedString.networkErrUpdateUserGobePassRequired()
		case .UpdateUserNickNameLengh:
			return LocalizedString.networkErrUpdateUserNickNameLengh()
		case .UpdateUserAddressLenghBetween:
			return LocalizedString.networkErrUpdateUserAddressLenghBetween()
		case .UpdateUserFitbitTokenRequired:
			return LocalizedString.networkErrUpdateUserFitbitTokenRequired()
		case .UpdateUserHealthSourceRequired:
			return LocalizedString.networkErrUpdateUserHealthSourceRequired()
		case .UpdateUserAvailable:
			return LocalizedString.networkErrUpdateUserAvailable()
		case .UpdateUserOldUnderV2:
			return LocalizedString.networkErrUpdateUserOldUnderV2()
		case .UpdateUserEmailExist:
			return LocalizedString.networkErrUpdateUserEmailExist()
		// MARK: -------------------------------- /api/v1/user/detail --------------------------------
		case .GetUserNameNotExist:
			return LocalizedString.networkErrGetUserNameNotExist()
		// MARK: -------------------------------- /api/v1/user/password --------------------------------
		case .UpdatePassRequired:
			return LocalizedString.networkErrUpdatePassRequired()
		case .UpdatePassLengh:
			return LocalizedString.networkErrUpdatePassLengh()
		case .UpdatePassLenghBetween:
			return LocalizedString.networkErrUpdatePassLenghBetween()
		case .UpdateCurrentPassRequired:
			return LocalizedString.networkErrUpdateCurrentPassRequired()
		case .UpdateNewPassLengh:
			return LocalizedString.networkErrUpdateNewPassLengh()
		case .UpdateNewPassLenghBetween:
			return LocalizedString.networkErrUpdateNewPassLenghBetween()
		case .UpdatePassDupplicate:
			return LocalizedString.networkErrUpdatePassDupplicate()
		case .UpdatePassIncorrect:
			return LocalizedString.networkErrUpdatePassIncorrect()
		// MARK: -------------------------------- /api/v1/user/forgot_password --------------------------------
		case .SendCodeEmailRequired:
			return LocalizedString.networkErrSendCodeEmailRequired()
		case .SendCodeEmailNotExists:
			return LocalizedString.networkErrSendCodeEmailNotExists()
		case .SendCodeSentError:
			return LocalizedString.networkErrSendCodeSentError()
		// MARK: -------------------------------- /api/v1/user/active_password --------------------------------
		case .RecoverPassRequired:
			return LocalizedString.networkErrRecoverPassRequired()
		case .RecoverPassLengh:
			return LocalizedString.networkErrRecoverPassLengh()
		case .RecoverPassLenghBetween:
			return LocalizedString.networkErrRecoverPassLenghBetween()
		case .RecoverPassActiveCodeRequired:
			return LocalizedString.networkErrRecoverPassActiveCodeRequired()
		case .RecoverPassUserNotExists:
			return LocalizedString.networkErrRecoverPassUserNotExists()
		case .RecoverPassActiveCodeNotExists:
			return LocalizedString.networkErrRecoverPassActiveCodeNotExists()
		// MARK: -------------------------------- /api/v1/login_google --------------------------------
		// MARK: -------------------------------- /api/v1/login_facebook --------------------------------
		// MARK: -------------------------------- /api/v1/logout --------------------------------
		// MARK: -------------------------------- /api/v1/be_ecommerce/login --------------------------------
		case .LoginEcoUserRequired:
			return LocalizedString.networkErrLoginEcoUserRequired()
		case .LoginEcoUserLengh:
			return LocalizedString.networkErrLoginEcoUserLengh()
		case .LoginEcoUserLenghBetween:
			return LocalizedString.networkErrLoginEcoUserLenghBetween()
		case .LoginEcoUserLatin:
			return LocalizedString.networkErrLoginEcoUserLatin()
		case .LoginEcoPassRequired:
			return LocalizedString.networkErrLoginEcoPassRequired()
		case .LoginEcoPassLengh:
			return LocalizedString.networkErrLoginEcoPassLengh()
		case .LoginEcoPassLenghBetween:
			return LocalizedString.networkErrLoginEcoPassLenghBetween()
		case .Undefine_Error:
			return LocalizedString.networkErrUnknown()
		case .Facebook_Error_001:
			return "FacebookError001"
		case .Google_Error_001:
			return "GoogleError001"
		// MARK: -------------------------------- /api/v1/contest/user/join --------------------------------
		case .JoinContestPeriodTime:
			return LocalizedString.networkErrJoinContestPeriodTime()
		case .JoinContestAlreadyJoined:
			return LocalizedString.networkErrJoinContestAlreadyJoined()
		case .JoinContestNotInProgram:
			return LocalizedString.networkErrJoinContestNotInProgram()
		case .JoinContestMembershipType:
			return LocalizedString.networkErrJoinContestMembershipType()
		case .JoinContestGender:
			return LocalizedString.networkErrJoinContestGender()
		case .JoinContestHealthSource:
			return LocalizedString.networkErrJoinContestHealthSource()
		case .JoinContestAge:
			return LocalizedString.networkErrJoinContestGender()
		case .JoinContestBMI:
			return LocalizedString.networkErrJoinContestBMI()
		case .JoinContestDrinkingHabit:
			return LocalizedString.networkErrJoinContestDrinkingHabit()
		case .JoinContestSmokingHabit:
			return LocalizedString.networkErrJoinContestSmokingHabit()
		// MARK: -------------------------------- /api/v1/user_contest_challenge/start_stop --------------------------------
		case .StartStopChallengeUserNotJoin:
			return LocalizedString.networkErrStartStopChallengeUserNotJoin()
		case .StartStopChallengeIDNotExistInDatabase:
			return LocalizedString.networkErrStartStopChallengeIDNotExistInDatabase()
		case .StartStopChallengeNotInContest:
			return LocalizedString.networkErrStartStopChallengeNotInContest()
		case .StartStopChallengeContestNotExist:
			return LocalizedString.networkErrStartStopChallengeContestNotExist()
		case .StartStopChallengePlayingOtherContest:
			return LocalizedString.networkErrStartStopChallengePlayingOtherContest()
		}
	}
}

enum GKNetworkError: Error {
	case unknownError
	case incorrectDataReturned
	case connectionError
	case invalidCredentials
	case invalidRequest
	case updatePasswordError
	case notFound
	case invalidResponse
	case serverError
	case serverUnavailable
	case timeOut
	case tokenExpired
	case unsuppotedURL
	case fbError001
	case ggError001
	
	init(error: Any) {
		self = .unknownError
		// NSError response error
		if let nsError = error as? NSError {
			if nsError.domain == NSURLErrorDomain {
				switch nsError.code {
				case NSURLErrorUnknown:
					self = .unknownError
				case NSURLErrorCancelled:
					self = .unknownError
				case NSURLErrorBadURL:
					self = .incorrectDataReturned
				case NSURLErrorTimedOut:
					self = .timeOut
				case NSURLErrorUnsupportedURL:
					self = .serverUnavailable
				case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
					self = .connectionError
				case NSURLErrorDataLengthExceedsMaximum:
					self = .incorrectDataReturned
				case NSURLErrorNetworkConnectionLost:
					self = .connectionError
				case NSURLErrorDNSLookupFailed:
					self = .connectionError
				case NSURLErrorHTTPTooManyRedirects:
					self = .unknownError
				case NSURLErrorResourceUnavailable:
					self = .incorrectDataReturned
				case NSURLErrorNotConnectedToInternet:
					self = .connectionError
				case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
					self = .connectionError
				case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
					self = .unknownError
				case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
					self = .incorrectDataReturned
				case NSURLErrorCannotParseResponse:
					self = .incorrectDataReturned
				case NSURLErrorInternationalRoamingOff:
					self = .connectionError
				case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
					self = .unknownError
				case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
					self = .incorrectDataReturned
				case
				NSURLErrorNoPermissionsToReadFile,
				NSURLErrorSecureConnectionFailed,
				NSURLErrorServerCertificateHasBadDate,
				NSURLErrorServerCertificateUntrusted,
				NSURLErrorServerCertificateHasUnknownRoot,
				NSURLErrorServerCertificateNotYetValid,
				NSURLErrorClientCertificateRejected,
				NSURLErrorClientCertificateRequired,
				NSURLErrorCannotLoadFromNetwork,
				NSURLErrorCannotCreateFile,
				NSURLErrorCannotOpenFile,
				NSURLErrorCannotCloseFile,
				NSURLErrorCannotWriteToFile,
				NSURLErrorCannotRemoveFile,
				NSURLErrorCannotMoveFile,
				NSURLErrorDownloadDecodingFailedMidStream,
				NSURLErrorDownloadDecodingFailedToComplete:
					self = .unknownError
				default:
					self = .unknownError
				}
			}
			else {
				self = .unknownError
			}
		} else {
			// AF response error - check responseCode
			if let afError = error as? AFError {
				if let statusCode = afError.responseCode {
					switch statusCode {
					case 401:
						self = .tokenExpired
					default:
						self = .unknownError
					}
				}
			} else {
				self = .unknownError
			}
		}
	}
}

extension GKNetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .unknownError:
			return LocalizedString.localizedString(input: "Unknown_Error")
		case .connectionError:
			return "Connection error"
		case .invalidCredentials:
			return "Invalid Credentials"
		case .invalidRequest:
			return "Invalid Request"
		case .notFound:
			return "Not found data"
		case .invalidResponse:
			return "Invalid Response"
		case .serverError:
			return "Server get internal error"
		case .serverUnavailable:
			return "Server Unavailable"
		case .timeOut:
			return "Request timeout"
		case .unsuppotedURL:
			return "Invalid/Unsupport URL"
		case .incorrectDataReturned:
			return "Incorrect Data Returned"
		case .tokenExpired:
			return "Token Expired"
		case .updatePasswordError:
			return "Request timeout"
		case .fbError001:
			return "Facebook 001"
		case .ggError001:
			return "Google 001"
		}
	}
}

extension MoyaError {
	var toGKError: GKError {
		switch self {
		case .imageMapping(_):
			return GKError(networkError: .invalidRequest)
		case .jsonMapping(_):
			return GKError(networkError: .invalidRequest)
		case .stringMapping(_):
			return GKError(networkError: .invalidRequest)
		case .objectMapping(let error, let response):
			return GKError(networkError: GKNetworkError(error: error), response: response)
		case .statusCode(_):
			return GKError(networkError: .invalidRequest)
		case .underlying(let error, let response):
			return GKError(networkError: GKNetworkError(error: error), response: response)
		case .encodableMapping:
			return GKError(networkError: .invalidRequest)
		case .requestMapping:
			return GKError(networkError: .invalidRequest)
		case .parameterEncoding(let error):
			return GKError(networkError: GKNetworkError(error: error))
		}
	}
}

extension ResponseObject {
	
	@discardableResult
	func handleWithStatusCode() -> GKNetworkError? {
		switch self.status {
		case 200:
			return nil
		case 401:
			return nil
		case 400:
			if let errors = self.body as? [String], errors.count > 0 {
				switch errors[0] {
				case "LoginFB_001_E_001":
					return GKNetworkError.fbError001
				case "LoginGoogle_001_E_001":
					return GKNetworkError.ggError001
				default:
					return nil
				}
				
			}
			return nil
		default:
			return nil
		}
	}
}
