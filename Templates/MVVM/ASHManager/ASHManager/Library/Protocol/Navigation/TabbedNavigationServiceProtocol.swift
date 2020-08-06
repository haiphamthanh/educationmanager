//
//  TabbedNavigationServiceProtocol.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

protocol TabbedNavigationServiceProtocol: NavigationServiceProtocol {
	var rootNavigationControllers: [UINavigationController] { get }
	var moreNavigationController: UINavigationController { get }
	
	func setup(with tabBar: UITabBarController)
	func select(nav: UINavigationController)
}
