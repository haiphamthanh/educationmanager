//
//  TitleLabel.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class TitleLabel : AbstractLabel {
	override func fontProvider() -> UIFont {
		return GKFont.value()
	}
}

class TitleBoldLabel : AbstractLabel {
	override func fontProvider() -> UIFont {
		return GKFont.valueBold()
	}
}
