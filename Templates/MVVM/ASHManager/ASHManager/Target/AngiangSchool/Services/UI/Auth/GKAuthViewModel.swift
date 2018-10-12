//
//  GKAuthViewModel.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/3/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import FBSDKCoreKit
import GoogleSignIn

protocol ViewModelDataType {
	associatedtype Input
	associatedtype Output
	
	func transform(input: Input) -> Output
}

// MARK: - ########################## Customization ##########################
class GKAuthViewModel: AuthViewModel {
	// MARK: ================ Social login ================
	override func login(by userName: String, password: String) -> Observable<Void> {
		return gkNetworkService
			.login(userName: userName, password: password)
	}
	
	override func loginByFacebook(token: String) -> Observable<Void> {
		return gkNetworkService
			.loginFacebook(token: token)
	}
	
	override func loginByGoogle(user: GIDGoogleUser) -> Observable<Void> {
		return gkNetworkService
			.loginGoogle(token: user.authentication.accessToken)
	}
	
	// MARK: ================ By Email ================
//	override func login(with userName: String, password: String) {
//		let error = strongify(self, closure: { (instance, error: Error) in
//			instance.showDialog(error: error)
//		})
//
//		return gkNetworkService
//			.login(userName: userName, password: password)
//			.flatMap(didLogedIn)
//			.observeOn(MainScheduler.instance)
//			.subscribe(onError: error)
//			.disposed(by: disposeBag)
//	}
	
//	override func loginByGoogle(user: GIDGoogleUser) {
//		let error = strongify(self, closure: { (instance, error: Error) in
//			switch error.localizedDescription {
//			case "GoogleError001":
//				instance.signUpNewFrom(googleData: user)
//			default:
//				instance.showDialog(error: error)
//			}
//		})
//
//		return gkNetworkService
//			.loginGoogle(token: user.authentication.accessToken)
//			.flatMap(didLogedIn)
//			.observeOn(MainScheduler.instance)
//			.subscribe(onError: error)
//			.disposed(by: disposeBag)
//	}
//
//	override func loginByFacebook(token: String) {
//		let error = strongify(self, closure: { (instance, error: Error) in
//			switch error.localizedDescription {
//			case "FacebookError001":
//				instance.requestFacebookData(from: token)
//			default:
//				instance.showDialog(error: error)
//			}
//		})
//
//		return gkNetworkService.loginFacebook(token: token)
//			.flatMap(didLogedIn)
//			.observeOn(MainScheduler.instance)
//			.subscribe(onError: error)
//			.disposed(by: disposeBag)
//	}
}

// MARK: - ================================= Private =================================
private extension GKAuthViewModel {
//	func requestFacebookData(from token: String) {
//		let fbLoadSuccess = strongify(self, closure: { (instance, fbData: [String : String]) in
//			instance.signUpNewFrom(fbData: fbData)
//		})
//		
//		let fbLoaderror = strongify(self, closure: { (instance, error: Error) in
//			instance.showDialog(error: error)
//		})
//		
//		let fbHandler: FBSDKGraphRequestHandler = { (connection, result, error) -> Void in
//			if error != nil {
//				return fbLoaderror(error!)
//			}
//			
//			guard let result = result as? [String : String] else { return }
//			return fbLoadSuccess(result)
//		}
//		
//		let req = FBSDKGraphRequest(graphPath: "me",
//									parameters: ["fields": "email, last_name, first_name, name, birthday"],
//									tokenString: token,
//									version: nil,
//									httpMethod: "GET")
//		let _ = req?.start(completionHandler: fbHandler)
//	}
//	
//	func signUpNewFrom(fbData: [String: String]?) -> Observable<Dictionary<String, Any>?> {
//		guard let fbData = fbData, let facebookID = fbData["id"] else {
//			return Observable.never()
//		}
//		
//		let profilePic = "http://graph.facebook.com/\(facebookID)/picture?type=large"
//		
//		let userInfo = SocialUserInfo(email: fbData["email"] ?? "",
//									  birthday: fbData["birthday"] ?? "",
//									  lastName: fbData["last_name"] ?? "",
//									  firstName: fbData["first_name"] ?? "",
//									  name: fbData["name"] ?? "",
//									  profilePic: profilePic)
//		let socialData = SocialData(userInfo: userInfo, type: .Facebook, id: facebookID)
//		
//		return signUpNew(with: socialData)
//	}
//	
//	func signUpNewFrom(googleData: GIDGoogleUser) -> Observable<Dictionary<String, Any>?> {
//		let userID = googleData.userID
//		var profilePic = ""
//		if googleData.profile.hasImage {
//			profilePic = googleData.profile.imageURL(withDimension: 120).absoluteString
//		}
//		
//		let userInfo = SocialUserInfo(email: googleData.profile.email,
//									  birthday: "",
//									  lastName: "",
//									  firstName: googleData.profile.givenName,
//									  name: googleData.profile.name,
//									  profilePic: profilePic)
//		
//		let socialData = SocialData(userInfo: userInfo, type: .GooglePlus, id: userID!)
//		
//		return signUpNew(with: socialData)
//	}
//	
//	func signUpNew(with socialData: SocialData) -> Observable<Dictionary<String, Any>?> {
//		return _signup
//		//TODO: transfrom socialData -> UserData and passing view controller through params
////		return coordinator
////			.signUp(params: nil)
////			.subscribe()
////			.dispose()
//	}
}
