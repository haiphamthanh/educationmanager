//
//  DeviceButton.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class DeviceButton: AbstractButton {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
		backgroundColor = .white
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.valueBold()
	}
}
