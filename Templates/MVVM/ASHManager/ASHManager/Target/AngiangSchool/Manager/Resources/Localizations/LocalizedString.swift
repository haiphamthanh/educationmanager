//
//  LocalizedString.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Localize_Swift

enum currentLocation: Int {
	case france = 0
	case english
	case japan
	case vietnam
	
	func locationCode() -> String {
		switch self {
		case .france:
			return "fr"
		case .english:
			return "en"
		case .japan:
			return "jp"
		case .vietnam:
			return "vn"
		}
	}
}

class LocalizeTable {
	static let NORMAL = "NormalLocalizable"
	static let NETWORK = "NetworkLocalizable"
	static let LOGIN = "NormalLocalizable"
	static let FORGOT_PASSWORD = "NormalLocalizable"
	static let HEALTH_INFORMATION = "NormalLocalizable"
	static let TERMS_OF_USE = "NormalLocalizable"
	static let MESSAGE = "NormalLocalizable"
}

class LocalizedString: NSObject {
	
	// MARK: - ================================= Config =================================
	static func changeCurrentLocation(currentLocation: currentLocation) {
		Localize.setCurrentLanguage(currentLocation.locationCode())
	}
	
	// MARK: - ================================= LocalizeTable.NORMAL =================================
	static func titleHome() -> String { return "Title_Home".localized(using: LocalizeTable.NORMAL) }
	static func localizedString(input: String) -> String { return input.localized(using: LocalizeTable.NORMAL) }
	static func titleCamera() -> String { return "Title_Camera".localized(using: LocalizeTable.NORMAL) }
	static func titlePopup() -> String { return "Title_Popup".localized(using: LocalizeTable.NORMAL) }
	
	static func titlePhoto() -> String { return "Title_Photo".localized(using: LocalizeTable.NORMAL) }
	static func titleAgree() -> String { return "Title_Agree".localized(using: LocalizeTable.NORMAL) }
	static func dateFormatter() -> String { return "DateFormatter".localized(using: LocalizeTable.NORMAL) }
	static func nodata() -> String { return "No_Data".localized(using: LocalizeTable.NORMAL) }
	static func unknown() -> String { return "Unknown".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= IntroView =================================
	static func titleIntroduct() -> String { return "IntroView.Title.Lable".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct() -> String { return "IntroView.Content.Lable".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct1() -> String { return "IntroView.Content.Lable1".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct2() -> String { return "IntroView.Content.Lable2".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct3() -> String { return "IntroView.Content.Lable3".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct4() -> String { return "IntroView.Content.Lable4".localized(using: LocalizeTable.NORMAL) }
	static func contentIntroduct5() -> String { return "IntroView.Content.Lable5".localized(using: LocalizeTable.NORMAL) }
	static func titleHeadingIntroduct() -> String { return "IntroView.Title.headingLable".localized(using: LocalizeTable.NORMAL) }
	static func titleButtonRegisterIntroduct() -> String { return "IntroView.Button.Register".localized(using: LocalizeTable.NORMAL) }
	static func titleButtonLoginIntroduct() -> String { return "IntroView.Button.Login".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= ResetPass =================================
	static func resetPassContent() -> String { return "ResetPass.Content.Lable".localized(using: LocalizeTable.NORMAL) }
	static func resetPassEmailPlaceHoder() -> String { return "ResetPass.PlaceHoderTextFeild".localized(using: LocalizeTable.NORMAL) }
	static func resetPassSendButtonTitle() -> String { return "ResetPass.SendButton.Title".localized(using: LocalizeTable.NORMAL) }
	static func resetPassLableTitle() -> String { return "ResetPass.Title.Lable" .localized(using: LocalizeTable.NORMAL) }
	static func pincodeTittle() -> String { return "PinCode.Text".localized(using: LocalizeTable.NORMAL) }
	static func oldPasswordTittle() -> String { return "OldPassword.Text".localized(using: LocalizeTable.NORMAL) }
	static func passwordTittle() -> String { return "Password.Text".localized(using: LocalizeTable.NORMAL) }
	static func confirmPasswordTittle() -> String { return "Confirm.Password.Text".localized(using: LocalizeTable.NORMAL) }
	static func changeButtonTittle() -> String { return "Change.Button.Text" .localized(using: LocalizeTable.NORMAL) }
	static func changePasswordButtonTittle() -> String { return "ChangePassword.Button.Text" .localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Location =================================
	static func titleBarCode() -> String { return "Title_Bar_Code".localized(using: LocalizeTable.NORMAL) }
	static func titleGPS() -> String { return "Title_GPS".localized(using: LocalizeTable.NORMAL) }
	static func titleCheckingLocation() -> String { return "Title_Checking_Location".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= LocalizeTable.LOGIN =================================
	static func titleLogin() -> String { return "Title_Login".localized(using: LocalizeTable.LOGIN) }
	static func titleFacebookLogin() -> String { return "Title_Facebook_Login".localized(using: LocalizeTable.LOGIN) }
	static func titleGoogleLogin() -> String { return "Title_Google_Login".localized(using: LocalizeTable.LOGIN) }
	static func titleAgreeTermOfUse() -> String { return "Title_Agree_Term_Of_Use".localized(using: LocalizeTable.LOGIN) }
	static func titleForgotPassword() -> String { return "Title_Forgot_Password".localized(using: LocalizeTable.LOGIN) }
	static func titleForgotPasswordMessage() -> String { return "Title_Forgot_Password_Message".localized(using: LocalizeTable.LOGIN) }
	static func titleInputUsername() -> String { return "Title_Input_Username".localized(using: LocalizeTable.LOGIN) }
	static func titleInputUsernameOrEmail() -> String { return "Title_Input_Username_Or_Email".localized(using: LocalizeTable.LOGIN) }
	static func titleInputPassword() -> String { return "Title_input_password".localized(using: LocalizeTable.LOGIN) }
	static func titleEmailAdress() -> String { return "Title_email_address".localized(using: LocalizeTable.LOGIN) }
	static func titlePassword() -> String { return "Title_password".localized(using: LocalizeTable.LOGIN) }
	static func titleChangePassword() -> String { return "Title_Change_Password".localized(using: LocalizeTable.LOGIN) }
	static func titleResetPassword() -> String { return "Title_Reset_Password".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= LocalizeTable.FORGOT_PASSWORD =================================
	static func titleSendEmail() -> String { return "Title_Send_Email".localized(using: LocalizeTable.FORGOT_PASSWORD) }
	static func titleInputEmail() -> String { return "Title_Input_Email".localized(using: LocalizeTable.FORGOT_PASSWORD) }
	static func titleSend() -> String { return "Title_Send".localized(using: LocalizeTable.FORGOT_PASSWORD) }
	
	// MARK: - ================================= LocalizeTable.HEALTH_INFORMATION =================================
	static func titleHealthInformation() -> String { return "Title_Health_Information".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	static func titleRegisterUserInfomation() -> String { return "Title_Register_User_Infomation".localized(using: LocalizeTable.HEALTH_INFORMATION)}
	static func titleYear() -> String { return "Title_Infomation_Year".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	static func titleMonth() -> String { return "Title_Infomation_Month".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	static func titleDay() -> String { return "Title_Infomation_Day".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	static func titleEnBirthday() -> String { return "Title_Health_Information_Birthday".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	static func titleCurrentDay() -> String { return "Title_Current_Date_Format".localized(using: LocalizeTable.HEALTH_INFORMATION) }
	
	// MARK: - ================================= LocalizeTable.TERMS_OF_USE =================================
	static func titleTermsOfUse() -> String { return "Title_Terms_Of_Use".localized(using: LocalizeTable.NORMAL) }
	static func titlePrivacyPolicy() -> String { return "Title_Privacy_Policy".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Register =================================
	static func naviBeerTitle() -> String { return "Register.Beer.NaviTitle".localized(using: LocalizeTable.NORMAL) }
	static func beerTitleLable() -> String { return "Register.Beer.Title.Label".localized(using: LocalizeTable.NORMAL) }
	static func naviSmokeTitle() -> String { return "Register.Smoke.NaviTitle".localized(using: LocalizeTable.NORMAL) }
	static func smokeTitleLable() -> String { return "Register.Smoke.Title.Label".localized(using: LocalizeTable.NORMAL) }
	static func beerCheckBoxTitle1() -> String { return "Register.Beer.CheckBoxTitle1.Label".localized(using: LocalizeTable.NORMAL) }
	static func beerCheckBoxTitle2() -> String { return "Register.Beer.CheckBoxTitle2.Label".localized(using: LocalizeTable.NORMAL) }
	static func beerCheckBoxTitle3() -> String { return "Register.Beer.CheckBoxTitle3.Label".localized(using: LocalizeTable.NORMAL) }
	static func beerCheckBoxTitle4() -> String { return "Register.Beer.CheckBoxTitle4.Label".localized(using: LocalizeTable.NORMAL) }
	static func nextButtonTitle() -> String { return "Register.Button.Next".localized(using: LocalizeTable.NORMAL) }
	static func registerButtonTitle() -> String { return "Register.Button.Register".localized(using: LocalizeTable.NORMAL) }
	static func skipAllButtonTitle() -> String { return "Register.Button.SkipAll".localized(using: LocalizeTable.NORMAL) }
	static func birthdayTitle() -> String { return "Title_BirthDay".localized(using: LocalizeTable.NORMAL) }
	static func deviceTitle() -> String { return "Title_Device".localized(using: LocalizeTable.NORMAL) }
	static func deviceDescriptionTitle() -> String { return "Title_Device_Description".localized(using: LocalizeTable.NORMAL) }
	static func otherWearableButtonTitle() -> String { return "Title_Other_Wearable_Button".localized(using: LocalizeTable.NORMAL) }
	static func smartPhoneTitle() -> String { return "Title_Smart_Phone_Button".localized(using: LocalizeTable.NORMAL) }
	static func gobeTitle() -> String { return "Title_Gobe".localized(using: LocalizeTable.NORMAL) }
	static func fitbitTitle() -> String { return "Title_Fitbit".localized(using: LocalizeTable.NORMAL) }
	static func popUpNameTitle() -> String { return "Popup_Name".localized(using: LocalizeTable.NORMAL) }
	
	static func nikeTitle() -> String { return "Nike_Button".localized(using: LocalizeTable.NORMAL) }
	static func acerTitle() -> String { return "Acer_Liquid_Leap".localized(using: LocalizeTable.NORMAL) }
	static func xiaomiTitle() -> String { return "Xiaomi".localized(using: LocalizeTable.NORMAL) }
	static func noteTitle() -> String { return "Note".localized(using: LocalizeTable.NORMAL) }
	
	static func genderTitle() -> String { return "Gender".localized(using: LocalizeTable.NORMAL) }
	static func weightTitle() -> String { return "Title_Weight".localized(using: LocalizeTable.NORMAL) }
	static func heightTitle() -> String { return "Height".localized(using: LocalizeTable.NORMAL) }
	static func bloodTypeTitle() -> String { return "Blood_Type".localized(using: LocalizeTable.NORMAL) }
	static func bloodPressureTitle() -> String { return "Blood_Pressure".localized(using: LocalizeTable.NORMAL) }
	static func textQuestionTitle() -> String { return "Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func checkBox1Title() -> String { return "CheckBox1".localized(using: LocalizeTable.NORMAL) }
	static func checkBox2Title() -> String { return "CheckBox2".localized(using: LocalizeTable.NORMAL) }
	static func checkBox3Title() -> String { return "CheckBox3".localized(using: LocalizeTable.NORMAL) }
	static func checkBox4Title() -> String { return "CheckBox4".localized(using: LocalizeTable.NORMAL) }
	static func checkBox5Title() -> String { return "CheckBox5".localized(using: LocalizeTable.NORMAL) }
	static func checkBox6Title() -> String { return "CheckBox6".localized(using: LocalizeTable.NORMAL) }
	static func checkBox7Title() -> String { return "CheckBox7".localized(using: LocalizeTable.NORMAL) }
	static func drinkTextQuestionTitle() -> String { return "Drink_Text_Question".localized(using: LocalizeTable.NORMAL) }
	
	static func drinkPopupCheckbox1Title() -> String { return "Drink_Popup_CheckBox1".localized(using: LocalizeTable.NORMAL) }
	static func drinkPopupCheckbox2Title() -> String { return "Drink_Popup_CheckBox2".localized(using: LocalizeTable.NORMAL) }
	static func drinkPopupCheckbox3Title() -> String { return "Drink_Popup_CheckBox3".localized(using: LocalizeTable.NORMAL) }
	static func drinkPopupCheckbox4Title() -> String { return "Drink_Popup_CheckBox4".localized(using: LocalizeTable.NORMAL) }
	static func drinkPopupCheckbox5Title() -> String { return "Drink_Popup_CheckBox5".localized(using: LocalizeTable.NORMAL) }
	static func drinkPopupCheckbox6Title() -> String { return "Drink_Popup_CheckBox6".localized(using: LocalizeTable.NORMAL) }
	
	static func smokeTextQuestionTitle() -> String { return "Smoke_Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func smokeCheckbox1Title() -> String { return "Smoke_Checkbox1".localized(using: LocalizeTable.NORMAL) }
	static func smokeCheckbox2Title() -> String { return "Smoke_Checkbox2".localized(using: LocalizeTable.NORMAL) }
	static func smokeCheckbox3Title() -> String { return "Smoke_Checkbox3".localized(using: LocalizeTable.NORMAL) }
	
	static func smokePupupTextQuestionTitle() -> String { return "Smoke_Popup_Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func smokePopupCheckbox1Title() -> String { return "Smoke_Popup_Checkbox1".localized(using: LocalizeTable.NORMAL) }
	static func smokePopupCheckbox2Title() -> String { return "Smoke_Popup_Checkbox2".localized(using: LocalizeTable.NORMAL) }
	static func smokePopupCheckbox3Title() -> String { return "Smoke_Popup_Checkbox3".localized(using: LocalizeTable.NORMAL) }
	
	static func surgeryTextQuestionTitle() -> String { return "Surgery_Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func yesTitle() -> String { return "Yes".localized(using: LocalizeTable.NORMAL) }
	static func noTitle() -> String { return "No".localized(using: LocalizeTable.NORMAL) }
	
	static func healthTextQuestionTitle() -> String { return "Health_Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func healthCheckbox1Title() -> String { return "Health_Checkbox1".localized(using: LocalizeTable.NORMAL) }
	static func healthCheckbox2Title() -> String { return "Health_Checkbox2".localized(using: LocalizeTable.NORMAL) }
	static func healthCheckbox3Title() -> String { return "Health_Checkbox3".localized(using: LocalizeTable.NORMAL) }
	static func healthCheckbox4Title() -> String { return "Health_Checkbox4".localized(using: LocalizeTable.NORMAL) }
	
	static func nicknameTextQuestionTitle() -> String { return "Nickname_Text_Question".localized(using: LocalizeTable.NORMAL) }
	static func nicknameTitle() -> String { return "Nick_Name".localized(using: LocalizeTable.NORMAL) }
	
	static func choosePicTitle() -> String { return "Avatar_Text_Choose_Pic".localized(using: LocalizeTable.NORMAL) }
	static func selectPicTitle() -> String { return "Avatar_Text_Select_Pic".localized(using: LocalizeTable.NORMAL) }
	static func takePicTitle() -> String { return "Avatar_Text_Take_Pic".localized(using: LocalizeTable.NORMAL) }
	
	static func createAccountTextTitle() -> String { return "Create_Account_Text".localized(using: LocalizeTable.NORMAL) }
	static func agreementTextTitle() -> String { return "Agreement_Text".localized(using: LocalizeTable.NORMAL) }
	static func placeholderUserNameTitle() -> String { return "Placeholder_UserName".localized(using: LocalizeTable.NORMAL) }
	static func placeholderMailTitle() -> String { return "Placeholder_Mail".localized(using: LocalizeTable.NORMAL) }
	static func placeholderPasswordTitle() -> String { return "Placeholder_Password".localized(using: LocalizeTable.NORMAL) }
	static func placeholderFirstNameTitle() -> String { return "Placeholder_FirstName".localized(using: LocalizeTable.NORMAL) }
	static func placeholderLastNameTitle() -> String { return "Placeholder_LastName".localized(using: LocalizeTable.NORMAL) }
	static func noteCreateAccountTitle() -> String { return "Note_Create_Account".localized(using: LocalizeTable.NORMAL) }
	
	static func registerNotiTitle() -> String { return "Register_Text_Noti".localized(using: LocalizeTable.NORMAL) }
	
	static func finishNotiTitle() -> String { return "Finish_Noti".localized(using: LocalizeTable.NORMAL) }
	
	static func forgotPassTitle() -> String { return "Title_Forgot_Pass".localized(using: LocalizeTable.NORMAL) }
	
	static func maleTitle() -> String { return "male".localized(using: LocalizeTable.NORMAL) }
	static func femaleTitle() -> String { return "female".localized(using: LocalizeTable.NORMAL) }
	
	static func thisMonthTitle() -> String { return "Title_This_Month".localized(using: LocalizeTable.NORMAL) }
	static func monneyTitle() -> String { return "Title_Money".localized(using: LocalizeTable.NORMAL) }
	
	static func nameOfFoodTitle() -> String { return "Title_Name_Of_Food".localized(using: LocalizeTable.NORMAL) }
	static func proteinTitle() -> String { return "Title_Protein".localized(using: LocalizeTable.NORMAL) }
	static func fatTitle() -> String { return "Title_Fat".localized(using: LocalizeTable.NORMAL) }
	static func carbonhidrateTitle() -> String { return "Title_Carbonhidrate".localized(using: LocalizeTable.NORMAL) }
	static func caloriesTitle() -> String { return "Title_Calories".localized(using: LocalizeTable.NORMAL) }
	
	static func recordTitle() -> String { return "Title_Record".localized(using: LocalizeTable.NORMAL) }
	static func addFoodTitle() -> String { return "Title_Add_Food".localized(using: LocalizeTable.NORMAL) }
	
	static func caloriesInTitle() -> String { return "Title_Calories_IN".localized(using: LocalizeTable.NORMAL) }
	static func caloriesOutTitle() -> String { return "Title_Calories_OUT".localized(using: LocalizeTable.NORMAL) }
	static func attachmentTitle() -> String { return "Title_Attachment".localized(using: LocalizeTable.NORMAL) }
	static func searchTitle() -> String { return "Title_Search".localized(using: LocalizeTable.NORMAL) }
	static func languageTitle() -> String { return "Title_Language".localized(using: LocalizeTable.NORMAL) }
	
	
	
	// MARK: - ================================= LocalizeTable.PAIDPLAN =================================
	static func paidPlanNaviTitle() -> String { return "Paid_Plan_Navi_Title".localized(using: LocalizeTable.NORMAL) }
	static func	paidPlanHeaderTitleLabel() -> String { return "Paid_Plan_Header_Title_Label".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanDetailNaviTitle() -> String { return "Paid_Plan_Detail_Navi_Title".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanSelectedPayTitle() -> String { return "Paid_Plan_Selected_Pay_Title".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanSelectedPayDefaultTitle() -> String { return "Paid_Plan_Selected_Pay_Default_Title".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanOptionPayTitle() -> String { return "Paid_Plan_Option_Pay_Title".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanOptionPayDefaultTitle() -> String { return "Paid_Plan_Option_Pay_Default_Title".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanExpire() -> String { return "Paid_Plan_Expire".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanExpireDate() -> String { return "Paid_Plan_Date_Format".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanBuy() -> String { return "Paid_Plan_Button_Buy".localized(using: LocalizeTable.NORMAL) }
	static func paidPlanChange() -> String { return "Paid_Plan_Button_Change".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Dashboard =================================
	static func dashboardTittle() -> String { return "Dashboard_Tittle".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Setting =================================
	static func settingTittle() -> String { return "Setting_Tittle".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Edit Profile =================================
	static func editProfileTittle() -> String { return "Edit_Profile_Tittle".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Notification =================================
	static func notificationTittle() -> String { return "Notification_Tittle".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Content Feed =================================
	static func contentFeedTittle() -> String { return "Content_Feed_Tittle".localized(using: LocalizeTable.NORMAL) }
	static func contentFeedAds() -> String { return "Content_Feed_Advertisement".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Contests =================================
	static func challengeDetailTitle() -> String { return "Challenge_Detail_Title".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Contests =================================
	static func contestsTittle() -> String { return "Contests_Tittle".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Reward =================================
	static func rewardHistoryTittle() -> String { return "Reward_History".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Done =================================
	static func doneButton() -> String { return "Keyboard.Button.Done".localized(using: LocalizeTable.NORMAL) }
	static func cancelButton() -> String { return "Keyboard.Button.Cancel".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= MESSAGE =================================
	static func titleSendMailSuccess() -> String { return "Title_Send_Mail_Success".localized(using: LocalizeTable.MESSAGE) }
	static func titleChangePasswordSuccess() -> String { return "Title_Change_Password_Success".localized(using: LocalizeTable.MESSAGE) }
	
	// MARK: - ================================= Done =================================
	static func titleChatWithWatson() -> String { return "Title_Chat_With_Watson".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - ================================= Done =================================
	static func titleGoBeDeviceProfilePopup() -> String { return "Title_GoBe_Device_Profile_Popup".localized(using: LocalizeTable.NORMAL) }
	static func titleFitBitDeviceProfilePopup() -> String { return "Title_FitBit_Device_Profile_Popup".localized(using: LocalizeTable.NORMAL) }
	
	// MARK: - -------------------------------- SpeechRecognition --------------------------------
	static func titleRecognition() -> String { return "Speech recognition".localized(using: LocalizeTable.NORMAL) }
	static func titleDoneButton() -> String { return "Done".localized(using: LocalizeTable.NORMAL) }
	
	
	// MARK: - ================================= LocalizeTable.NETWORK =================================
	// MARK: -------------------------------- Common message --------------------------------
	static func networkErrUnknown() -> String { return "NetworkError_Unknown".localized(using: LocalizeTable.NETWORK) }
	static func networkErrNotConnectedToInternet() -> String { return "NetworkError_NotConnectedToInternet".localized(using: LocalizeTable.NETWORK) }
	static func networkErrInternationalRoamingOff() -> String { return "NetworkError_InternationalRoamingOff".localized(using: LocalizeTable.NETWORK) }
	static func networkErrNotReachedServer() -> String { return "NetworkError_NotReachedServer".localized(using: LocalizeTable.NETWORK) }
	static func networkErrConnectionLost() -> String { return "NetworkError_ConnectionLost".localized(using: LocalizeTable.NETWORK) }
	static func networkErrIncorrectDataReturned() -> String { return "NetworkError_IncorrectDataReturned".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginAdmin() -> String { return "NetworkError_LoginAdmin".localized(using: LocalizeTable.NETWORK) }
	
	static func networkErrTokenExpire() -> String { return "C_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrTokenInvalid() -> String { return "C_E_005".localized(using: LocalizeTable.NETWORK) }
	static func networkErrTokenRequired() -> String { return "C_E_006".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/login --------------------------------
	static func networkErrLoginUserNameRequired() -> String { return "Login_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginPasswordRequired() -> String { return "Login_001_E_005".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginInputIncorrectV1() -> String { return "Login_001_E_008".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginInputIncorrectV2() -> String { return "Login_001_E_009".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginInputEmpty() -> String { return "Login_001_E_013".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/register --------------------------------
	static func networkErrRegisterUserRequired() -> String { return "RegisterUser_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterUserLengh() -> String { return "RegisterUser_001_E_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterUserLenghBetween() -> String { return "RegisterUser_001_E_003".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterUserLatin() -> String { return "RegisterUser_001_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterPassRequired() -> String { return "RegisterUser_001_E_005".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterPassLengh() -> String { return "RegisterUser_001_E_006".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterPassLenghBetween() -> String { return "RegisterUser_001_E_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterEmailRequired() -> String { return "RegisterUser_001_E_008".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterEmailFormat() -> String { return "RegisterUser_001_E_009".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterEmailLenghBetween() -> String { return "RegisterUser_001_E_010".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterOldUnderV1() -> String { return "RegisterUser_001_E_043".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterDateFormat() -> String { return "RegisterUser_001_E_011".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterImageFormat() -> String { return "RegisterUser_001_E_044".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterImageSize() -> String { return "RegisterUser_001_E_014".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterFirstNameLengh() -> String { return "RegisterUser_001_E_015".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterLastNameLengh() -> String { return "RegisterUser_001_E_016".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterHeighRequired() -> String { return "RegisterUser_001_E_017".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterWeighRequired() -> String { return "RegisterUser_001_E_022".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterGobeUserRequired() -> String { return "RegisterUser_001_E_057".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterGobePassRequired() -> String { return "RegisterUser_001_E_058".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterNickNameLengh() -> String { return "RegisterUser_001_E_047".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterNickNameLenghBetween() -> String { return "RegisterUser_001_E_048".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterHealthSourceRequired() -> String { return "RegisterUser_001_E_059".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterFitbitTokenRequired() -> String { return "RegisterUser_001_E_061".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterUserAvailable() -> String { return "RegisterUser_001_E_041".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterEmailAvailable() -> String { return "RegisterUser_001_E_042".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterOldUnderV2() -> String { return "RegisterUser_001_E_055".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterSentError() -> String { return "RegisterUser_001_E_056".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterHeighLessZero() -> String { return "RegisterUser_001_E_068".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterWeighLessZero() -> String { return "RegisterUser_001_E_069".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterBloodPressureConfict() -> String { return "RegisterUser_001_E_081".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterRequireFirstName() -> String { return "RegisterUser_Require_FirstName".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterRequireLastName() -> String { return "RegisterUser_Require_LastName".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRegisterInputInvalidCharacter() -> String { return "RegisterUser_Contain_Special_Character".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/update --------------------------------
	static func networkErrUpdateUserEmailFormat() -> String { return "UpdateUser_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserEmailLenghBetween() -> String { return "UpdateUser_001_E_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserDateFormat() -> String { return "UpdateUser_001_E_003".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserOldUnderV1() -> String { return "UpdateUser_001_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserImageSize() -> String { return "UpdateUser_001_E_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserImageFormat() -> String { return "UpdateUser_001_E_008".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserFirstNameLengh() -> String { return "UpdateUser_001_E_009".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserLastNameLengh() -> String { return "UpdateUser_001_E_010".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserHeigh() -> String { return "UpdateUser_001_E_011".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserWeigh() -> String { return "UpdateUser_001_E_013".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserGobeUserRequired() -> String { return "UpdateUser_001_E_045".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserGobePassRequired() -> String { return "UpdateUser_001_E_046".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserNickNameLengh() -> String { return "UpdateUser_001_E_036".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserAddressLenghBetween() -> String { return "UpdateUser_001_E_037".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserFitbitTokenRequired() -> String { return "UpdateUser_001_E_047".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserHealthSourceRequired() -> String { return "UpdateUser_001_E_049".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserAvailable() -> String { return "UpdateUser_001_E_030".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserOldUnderV2() -> String { return "UpdateUser_001_E_044".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateUserEmailExist() -> String { return "UpdateUser_001_E_072".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/detail --------------------------------
	static func networkErrGetUserNameNotExist() -> String { return "GetUserInformationService_Err_01".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/password --------------------------------
	static func networkErrUpdatePassRequired() -> String { return "UpdatePassword_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdatePassLengh() -> String { return "UpdatePassword_001_E_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdatePassLenghBetween() -> String { return "UpdatePassword_001_E_003".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateCurrentPassRequired() -> String { return "UpdatePassword_001_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateNewPassLengh() -> String { return "UpdatePassword_001_E_005".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdateNewPassLenghBetween() -> String { return "UpdatePassword_001_E_006".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdatePassDupplicate() -> String { return "UpdatePassword_001_E_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrUpdatePassIncorrect() -> String { return "UpdatePassword_001_E_008".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/forgot_password --------------------------------
	static func networkErrSendCodeEmailRequired() -> String { return "SendCodePassword_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrSendCodeEmailNotExists() -> String { return "SendCodePassword_001_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrSendCodeSentError() -> String { return "SendCodePassword_001_E_005".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user/active_password --------------------------------
	static func networkErrRecoverPassRequired() -> String { return "SendCodePassword_001_E_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRecoverPassLengh() -> String { return "RecoverPassword_001_E_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRecoverPassLenghBetween() -> String { return "RecoverPassword_001_E_003".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRecoverPassActiveCodeRequired() -> String { return "RecoverPassword_001_E_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRecoverPassUserNotExists() -> String { return "RecoverPassword_001_E_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrRecoverPassActiveCodeNotExists() -> String { return "RecoverPassword_001_E_008".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/login_google --------------------------------
	// MARK: -------------------------------- /api/v1/login_facebook --------------------------------
	// MARK: -------------------------------- /api/v1/logout --------------------------------
	// MARK: -------------------------------- /api/v1/be_ecommerce/login --------------------------------
	static func networkErrLoginEcoUserRequired() -> String { return "Login_Ecommerce_Err_001".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoUserLengh() -> String { return "Login_Ecommerce_Err_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoUserLenghBetween() -> String { return "Login_Ecommerce_Err_003".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoUserLatin() -> String { return "Login_Ecommerce_Err_004".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoPassRequired() -> String { return "Login_Ecommerce_Err_006".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoPassLengh() -> String { return "Login_Ecommerce_Err_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrLoginEcoPassLenghBetween() -> String { return "Login_Ecommerce_Err_008".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/contest/user/join --------------------------------
	static func networkErrJoinContestPeriodTime() -> String { return "JoinContest_001_E_006".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestAlreadyJoined() -> String { return "JoinContest_001_E_007".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestNotInProgram() -> String { return "JoinContest_001_E_008".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestMembershipType() -> String { return "JoinContest_001_E_009".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestGender() -> String { return "JoinContest_001_E_010".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestHealthSource() -> String { return "JoinContest_001_E_016".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestAge() -> String { return "JoinContest_001_E_012".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestBMI() -> String { return "JoinContest_001_E_013".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestDrinkingHabit() -> String { return "JoinContest_001_E_014".localized(using: LocalizeTable.NETWORK) }
	static func networkErrJoinContestSmokingHabit() -> String { return "JoinContest_001_E_015".localized(using: LocalizeTable.NETWORK) }
	
	// MARK: -------------------------------- /api/v1/user_contest_challenge/start_stop --------------------------------
	static func networkErrStartStopChallengeUserNotJoin() -> String { return "StartStopChallenge_001_E_002".localized(using: LocalizeTable.NETWORK) }
	static func networkErrStartStopChallengeIDNotExistInDatabase() -> String { return "StartStopChallenge_001_E_005".localized(using: LocalizeTable.NETWORK) }
	static func networkErrStartStopChallengeNotInContest() -> String { return "StartStopChallenge_001_E_006".localized(using: LocalizeTable.NETWORK) }
	static func networkErrStartStopChallengeContestNotExist() -> String { return "StartStopChallenge_001_E_011".localized(using: LocalizeTable.NETWORK) }
	static func networkErrStartStopChallengePlayingOtherContest() -> String { return "StartStopChallenge_001_E_012".localized(using: LocalizeTable.NETWORK) }
}
