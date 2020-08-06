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
	// MARK: - ================================= Usage =================================
	func show(message: String)
	func show(message: String, type: ToastType)
	func show(message: String, type: ToastType, position: ToastPosition)
}
