//
//  BodyLable.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class BodyLabel : AbstractLabel {
	override func fontProvider() -> UIFont {
		return GKFont.body()
	}
}
