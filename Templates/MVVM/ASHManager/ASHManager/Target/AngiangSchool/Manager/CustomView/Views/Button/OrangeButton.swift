//
//  GenkiOrangeButton.swift
//  ASHManager
//
//  Created by ToanNV11 on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class OrangeButton: AbstractButton {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.backgroundColor = UIColor.orange.cgColor
		layer.cornerRadius = 4.0
		
		tintColor = UIColor.white
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.value()
	}
}
