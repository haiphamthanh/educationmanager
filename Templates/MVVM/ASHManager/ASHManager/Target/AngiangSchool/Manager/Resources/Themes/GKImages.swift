//
//  GKImages.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//
// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import UIKit

extension UIImage {
	enum Asset: String {
		case _1 = "1"
		case _2 = "2"
		case _3 = "3"
		case _4 = "4"
		case _5 = "5"
		case Back = "back"
		case HertIcon
		case PlusIcon
		case ShareIcon
		case TransparentPixel
		
		var image: UIImage {
			return UIImage(asset: self)
		}
	}
	
	convenience init!(asset: Asset) {
		self.init(named: asset.rawValue)
	}
}
