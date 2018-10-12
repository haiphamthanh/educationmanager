//
//  MenuCellData.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/11/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

struct MenuCellData {
	init(imageUrl: String, text: String) {
		self.imageUrl = imageUrl
		self.text = text
	}
	
	var imageUrl: String
	var text: String
}
