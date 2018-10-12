//
//  GradientVerticalView.swift
//  ASHManager
//
//  Created by HieuNT52 on 12/21/17.
//  Copyright © 2017 HieuNT52. All rights reserved.
//

import UIKit.UIView

class GradientView: UIView {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		addGradient()
	}
}

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
	case genkiApp
	
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
		case .genkiApp:
			return (x: CGPoint(x: 1, y: 0.05), y: CGPoint(x: 0.6, y: 1))
		}
	}
}

extension UIView {
	func addGradient(colors: [CGColor] = [Color.crimson.value.cgColor, Color.darkOrange.value.cgColor],
					 with type: GradientType = .genkiApp) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = colors
		gradientLayer.startPoint = type.draw().x
		gradientLayer.endPoint = type.draw().y
		layer.insertSublayer(gradientLayer, at: 0)
	}

	func addGradientBottomRightTopLeft(colors: [CGColor] = [Color.crimson.value.cgColor, Color.darkOrange.value.cgColor],
									   with type: GradientType = .bottomRightTopLeft) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = colors
		gradientLayer.startPoint = type.draw().x
		gradientLayer.endPoint = type.draw().y
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
