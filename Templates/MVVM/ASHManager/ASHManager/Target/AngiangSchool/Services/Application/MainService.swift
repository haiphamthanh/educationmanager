//
//  MainService.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/27/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import FBSDKCoreKit
import TwitterKit
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import UserNotifications

class MainService: BaseMainService {
	// MARK: - ================================= Overrided =================================
	override func app(_ app: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		setupServices()
		
		// Facebook
		return FBSDKApplicationDelegate.sharedInstance().application(app, didFinishLaunchingWithOptions: launchOptions)
	}
	
	override func app(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		let fitbitCode = url.query?.replacingOccurrences(of: "code=", with: "")
		NotificationCenter
			.default
			.post(name: NSNotification.Name(rawValue: "FitbitCode"), object: nil, userInfo: ["FitbitCode": fitbitCode ?? ""])
		
		let googleSignIn = GIDSignIn
			.sharedInstance()
			.handle(url,
					sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
					annotation: options[UIApplicationOpenURLOptionsKey.annotation] as? String)
		let twetterSigIn = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
		let facebookSignIn = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
		
		// no equiv. notification. return NO if the application can't open for some reason
		return googleSignIn && facebookSignIn && twetterSigIn
	}
	
	override func app(_ app: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		let googleSignIn = GIDSignIn
			.sharedInstance()
			.handle(url, sourceApplication: sourceApplication, annotation: annotation)
		let facebookSignIn = FBSDKApplicationDelegate
			.sharedInstance()
			.application(app, open: url, sourceApplication: sourceApplication, annotation: annotation)
		return googleSignIn && facebookSignIn
	}
}

private extension MainService {
	func setupServices() {
		setupExternalServices()
		setupNotification()
	}
	
	func setupExternalServices() {
		LocalizedString.changeCurrentLocation(currentLocation: .vietnam)
		
		//Twitter
		TWTRTwitter.sharedInstance().start(withConsumerKey: Config.TWITTER_API_KEY, consumerSecret: Config.TWITTER_API_SECRET)
		
		//Google
		GMSServices.provideAPIKey(Config.GOOGLE_MAP_API_KEY)
		GMSPlacesClient.provideAPIKey(Config.GOOGLE_MAP_PLACES_API_KEY)
	}
	
	func setupNotification() {
		registerForPushNotifications()
	}
	
	func registerForPushNotifications() {
		if #available(iOS 10.0, *) {
			let completion = { [weak self] (granted: Bool, error: Error?) in
				print("Permission granted: \(granted)")
				guard granted else {
					return
				}
				
				self?.configNotificationSettings()
			}
			
			UNUserNotificationCenter
				.current()
				.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: completion)
		} else {
			// Fallback on earlier versions
		}
	}
	
	func configNotificationSettings() {
		if #available(iOS 10.0, *) {
			let completion = { (settings: UNNotificationSettings) in
				guard settings.authorizationStatus == .authorized else {
					return
				}
				
				DispatchQueue.main.async(execute: {
					UIApplication.shared.registerForRemoteNotifications()
				})
			}
			
			UNUserNotificationCenter
				.current()
				.getNotificationSettings(completionHandler: completion)
		} else {
			// Fallback on earlier versions
		}
	}
}
