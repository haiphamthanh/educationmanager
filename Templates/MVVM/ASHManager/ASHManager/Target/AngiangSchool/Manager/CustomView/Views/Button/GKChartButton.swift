//
//  GKChartButton.swift
//  ASHManager
//
//  Created by TienNT12 on 1/18/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class GKChartButton: UIButton {
	
	@IBInspectable var color: UIColor = .white {
		didSet {
			backgroundColor = color
		}
	}
	
	@IBInspectable var borderColor: UIColor = .white {
		didSet {
			layer.borderColor = borderColor.cgColor
		}
	}
	
	@IBInspectable var boderWidth: CGFloat = 0.0 {
		didSet {
			layer.borderWidth = boderWidth
		}
	}
	
	@IBInspectable var cornerRadius: CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.cornerRadius = cornerRadius
		layer.borderColor = borderColor.cgColor
	}
}

class GKChartHighlight: UIButton {
	
	var lineView: UIView?
	@IBInspectable var selectedColor: UIColor = .white
	let deseletedColor: UIColor = .white
	let textSeletedColor: UIColor = .black
	let textDeseletedColor: UIColor = .lightGray
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		if lineView == nil {
			lineView = UIView(frame: CGRect.init(x: 0, y: frame.size.height - 2, width: frame.size.width, height: 2))
			lineView?.backgroundColor = isSelected ? selectedColor : deseletedColor
			addSubview(lineView!)
		}
		setTitleColor(textSeletedColor, for: .selected)
		setTitleColor(textDeseletedColor, for: .normal)
	}
	
	func updateStatus() {
		lineView?.backgroundColor = isSelected ? selectedColor : deseletedColor
	}
}
