//
//  ViewUtil.swift
//  ASHManager
//
//  Created by NamPC on 2/23/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

final class ViewUtil {
	
	class func blurView(bounds: CGRect) -> UIVisualEffectView {
		let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
		let blurView = UIVisualEffectView(effect: blur)
		blurView.frame = bounds
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		return blurView
	}
}
