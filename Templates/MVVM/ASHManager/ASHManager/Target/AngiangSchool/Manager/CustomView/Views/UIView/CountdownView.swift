//
//  CountdownView.swift
//  ASHManager
//
//  Created by TienNT12 on 2/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum ButtonActionTitle: String {
	case join = "Join"
	case leave = "Leave"
}

class CountdownView: UIView {
	
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var hourLabel: UILabel!
	@IBOutlet weak var minLabel: UILabel!
	@IBOutlet weak var secLabel: UILabel!
	@IBOutlet weak var joinButton: JoinButton!
	
	@IBOutlet weak var dayTimeLabel: UILabel!
	@IBOutlet weak var hourTimeLabel: UILabel!
	@IBOutlet weak var minTimeLabel: UILabel!
	@IBOutlet weak var secTimeLabel: UILabel!
	
	//	var subDayLabel = UILabel()
	//	var subHourLabel = UILabel()
	//	var subMinLabel = UILabel()
	//	var subSecLabel = UILabel()
	var labelYCenter: CGFloat = 0
	var timer: Timer? = nil
	var counter: Int = 0
	
	var subViewTintColor: UIColor = .white {
		didSet {
			dayLabel.textColor = subViewTintColor
			hourLabel.textColor = subViewTintColor
			minLabel.textColor = subViewTintColor
			secLabel.textColor = subViewTintColor
			deactiveAll()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		//		setupSubLabel(subLabel: subDayLabel, label: dayLabel, width: 17, text: "days")
		//		setupSubLabel(subLabel: subHourLabel, label: hourLabel, width: 23, text: "hrs")
		//		setupSubLabel(subLabel: subMinLabel, label: minLabel, width: 29, text: "mins")
		//		setupSubLabel(subLabel: subSecLabel, label: secLabel, width: 36, text: "secs")
		labelYCenter = dayLabel.center.y
		subViewTintColor = .white
		setupTime(timeInterval: 0)
		
		dayTimeLabel.text = LocalizedString.localizedString(input: "Contest_Detail_days")
		hourTimeLabel.text = LocalizedString.localizedString(input: "Contest_Detail_hours")
		minTimeLabel.text = LocalizedString.localizedString(input: "Contest_Detail_minutes")
		secTimeLabel.text = LocalizedString.localizedString(input: "Contest_Detail_seconds")
		joinButton.setTitle(LocalizedString.localizedString(input: "Join"), for: .normal)
	}
	
	func setupTime(timeInterval: Int) {
		dayLabel.text = "0"
		hourLabel.text = "0"
		minLabel.text = "0"
		secLabel.text = "0"
		
		if timeInterval <= 0 { return }
		
		counter = timeInterval
		if timer == nil {
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(repairTimeLabel), userInfo: nil, repeats: true)
		}
	}
	
	@objc func repairTimeLabel() {
		counter -= 1
		secLabel.text = "\(counter % 60)"
		minLabel.text = "\((counter / 60) % 60)"
		hourLabel.text = "\((counter / (60 * 60)) % 24)"
		dayLabel.text = "\(counter / (60 * 60 * 24))"
		
		if dayLabel.text != "0" {
			if !dayLabel.isActive {
				deactiveAll()
				dayLabel.active()
			}
		}
		
		if dayLabel.text == "0" && hourLabel.text != "0" {
			if !hourLabel.isActive {
				deactiveAll()
				hourLabel.active()
			}
		}
		
		if dayLabel.text == "0" && hourLabel.text == "0" && minLabel.text != "0" {
			if !minLabel.isActive {
				deactiveAll()
				minLabel.active()
			}
		}
		
		if dayLabel.text == "0" && hourLabel.text == "0" && minLabel.text == "0" && secLabel.text != "0" {
			if !secLabel.isActive {
				deactiveAll()
				secLabel.active()
			}
		}
		
		if counter <= 0 {
			deactiveAll()
			timer?.invalidate()
			timer = nil
		}
	}
	
	private func deactiveAll() {
		dayLabel.deactive()
		hourLabel.deactive()
		minLabel.deactive()
		secLabel.deactive()
	}
	
	private func setupSubLabel(subLabel: UILabel, label: UILabel, width: CGFloat, text: String) {
		label.textAlignment = .center
		
		subLabel.frame = CGRect(x: 0, y: label.frame.origin.y + 10, width: width, height: 30)
		subLabel.center.x = label.center.x
		subLabel.font = AppFont.openSans_Bold.size(.h3)
		subLabel.textColor = UIColor.white
		subLabel.alpha = 0.6
		subLabel.text = text
		subLabel.textAlignment = .center
		
		addSubview(subLabel)
	}
}

// TODO: Move to ultils
extension UILabel {
	
	private struct AssociatedKey {
		static var UILabelExtension = "UILabelExtension"
	}
	
	var isActive: Bool! {
		get {
			return objc_getAssociatedObject(self, &AssociatedKey.UILabelExtension) as? Bool
		}
		
		set(newValue) {
			objc_setAssociatedObject(self, &AssociatedKey.UILabelExtension, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func active() {
		font = AppFont.openSans_Bold.size(.size30)
		alpha = 1.0
		isActive = true
		layer.add(GKAnimationManager.transformAnimation(reverse: false), forKey: GKAnimationManagerKey.transform.rawValue)
	}
	
	func deactive() {
		font = AppFont.openSans_Bold.size(.size24)
		alpha = 0.6
		isActive = false
	}
}
