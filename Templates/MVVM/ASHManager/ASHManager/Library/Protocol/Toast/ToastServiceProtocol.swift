//
//  ToastServiceProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

enum ToastPosition {
	case top
	case left
	case right
	case bottom
	case center
}

enum ToastType {
	case normal
}

protocol ToastServiceProtocol {
	// MARK: - ================================= Init =================================
	func use(navigationService: BasicNavigationServiceProtocol)
	
	// MARK: - ================================= Usage =================================
	func toast(message: String)
	func toast(message: String, type: ToastType)
	func toast(message: String, type: ToastType, position: ToastPosition)
}
