//
//  SliderPageView.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class SliderPageView: UIView {
	@IBOutlet weak var nextButton: GKNextButton!
	@IBOutlet weak var skipAllButton: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = UIColor.clear
		
	}
	
	final func hiddenAllNextBack() {
		nextButton.isHidden = true
		skipAllButton.isHidden = true
	}
}
