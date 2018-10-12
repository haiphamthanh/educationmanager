//
//  StarsSelectionView.swift
//  ASHManager
//
//  Created by KhoaLA on 3/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class StarsSelectionView: UIView {
	
	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/
	
	var canSelect = false {
		didSet {
			for view in (subviews.first?.subviews.first?.subviews)! {
				if let imageView = view as? UIImageView {
					imageView.isUserInteractionEnabled = canSelect
				}
			}
		}
	}
	var totalStars = 5 {
		didSet {
			changeStarStatus()
		}
	}
	private let startYellow = "Star_Yellow"
	private let startGrey = "Star_Grey"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		for view in (subviews.first?.subviews.first?.subviews)! {
			if let imageView = view as? UIImageView {
				imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleStarTap)))
			}
		}
	}
	
	func setup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = self.bounds
		addSubview(view)
	}
	
	func loadViewFromNib() -> UIView? {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "StarsSelection", bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	func changeStarStatus() {
		switch totalStars {
		case 1:
			changeStarImage(images: [startYellow, startGrey, startGrey, startGrey,startGrey])
			break
		case 2:
			changeStarImage(images: [startYellow, startYellow, startGrey, startGrey, startGrey])
			break
		case 3:
			changeStarImage(images: [startYellow, startYellow, startYellow, startGrey, startGrey])
			break
		case 4:
			changeStarImage(images: [startYellow, startYellow, startYellow, startYellow, startGrey])
			break
		case 5:
			changeStarImage(images: [startYellow, startYellow, startYellow, startYellow, startYellow])
			break
		default:
			changeStarImage(images: [startGrey, startGrey, startGrey, startGrey, startGrey])
			break
		}
		if totalStars > 5 { changeStarImage(images: [startYellow, startYellow, startYellow, startYellow, startYellow]) }
	}
	
	@objc private func handleStarTap(gesture: UIGestureRecognizer) {
		if let view = gesture.view {
			totalStars = view.tag + 1
		}
	}
	
	private func changeStarImage(images: [String]) {
		for view in (subviews.first?.subviews.first?.subviews)! {
			if let imageView = view as? UIImageView {
				imageView.image = UIImage(named: images[imageView.tag])
			}
		}
	}
}
