//
//  NotOnlyUIManager.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

/// Used screens
///
class ASEPresentTextField: PresentTextField {
}

/// Used screens
///
class ASEDateTextField: TextFieldCustomization {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		viewType = TextFieldType.date.rawValue
	}
}
