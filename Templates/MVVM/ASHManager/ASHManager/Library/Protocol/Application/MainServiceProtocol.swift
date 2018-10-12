//
//  MainServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/27/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

protocol MainServiceProtocol {
	func app(_ app: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
	func appWillResignActive(_ app: UIApplication)
	func appDidEnterBackground(_ app: UIApplication)
	func appWillEnterForeground(_ app: UIApplication)
	func appDidBecomeActive(_ app: UIApplication)
	func appWillTerminate(_ app: UIApplication)
	func app(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool
	func app(_ app: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
}
