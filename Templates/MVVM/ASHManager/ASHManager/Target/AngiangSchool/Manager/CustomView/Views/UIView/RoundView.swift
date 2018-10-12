//
//  RoundView.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/23/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable
	var cornerBorderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var cornerBorderColor: UIColor = UIColor.white {
		didSet {
			layer.borderColor = cornerBorderColor.cgColor
		}
	}
}
