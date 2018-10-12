//
//  GKJoinButton.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 2/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import UIKit

class JoinButton: AbstractButton {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		backgroundColor = .clear
		
		layer.borderColor = UIColor.white.cgColor
		layer.borderWidth = 1.5
		
		layer.cornerRadius = self.frame.size.height/2
		layer.masksToBounds = true
		
		tintColor = UIColor.white
		
		contentHorizontalAlignment = .center
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.regularValue(with: .size24)
	}
}
