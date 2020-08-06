//
//  View+Animations.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

// Determine gradient coordinator
typealias GradientPoint = (x: CGPoint, y: CGPoint)
enum GradientType {
	case leftRight
	case rightLeft
	case topBottom
	case bottomTop
	case topLeftBottomRight
	case bottomRightTopLeft
	case topRightBottomLeft
	case bottomLeftTopRight
	case main
	
	func draw() -> GradientPoint {
		switch self {
		case .leftRight:
			return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
		case .rightLeft:
			return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
		case .topBottom:
			return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
		case .bottomTop:
			return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
		case .topLeftBottomRight:
			return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
		case .bottomRightTopLeft:
			return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
		case .topRightBottomLeft:
			return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
		case .bottomLeftTopRight:
			return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
		case .main:
			return (x: CGPoint(x: 1, y: 0.05), y: CGPoint(x: 0.6, y: 1))
		}
	}
}

extension ViewType {
	func relayoutView(_ sender: UIView) {
		switch self {
		case .normal:
			return normalCustom(sender)
		case .gradient:
			return normalCustom(sender)
		}
	}
}

// Private
private extension ViewType {
	func normalCustom(_ sender: UIView) {
	}
	
	func gradientCustom(_ sender: UIView) {
		sender.addGradient()
	}
}
