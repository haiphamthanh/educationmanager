//
//  GKCircularButton.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/23/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit
import Foundation

class GKCircularButton: UIButton {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.cornerRadius = bounds.size.width * 0.5
		layer.borderColor = UIColor.darkGray.cgColor
		layer.borderWidth = 1
		titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
		titleLabel?.textAlignment = NSTextAlignment.center
		clipsToBounds = true
	}
}

