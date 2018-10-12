//
//  AppUtil.swift
//  ASHManager
//
//  Created by 7i3u7u on 7/27/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit
import UserNotifications

class AppUtil {
	class func setBadgeIndicator(badgeCount: Int) {
		let application = UIApplication.shared
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
		} else {
			application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
		}
		
		application.registerForRemoteNotifications()
		application.applicationIconBadgeNumber = badgeCount
	}
}
