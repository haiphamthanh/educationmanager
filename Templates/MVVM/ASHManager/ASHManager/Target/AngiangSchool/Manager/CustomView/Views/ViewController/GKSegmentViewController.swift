//
//  GKSegmentViewController.swift
//  ASHManager
//
//  Created by TienNT12 on 3/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit
import RxSwift

class GKSegmentViewController: UIViewController {
	
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var selectedView: UIView!
	
	private var tintColor: UIColor = .white
	private var defaultColor: UIColor = .lightGray
	private var currentButton: UIButton!
	var valueChanged: BehaviorSubject<Int> = BehaviorSubject(value: 0)
	var currentSelected = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stackView.subviews.forEach { (view) in
			if let button = view as? UIButton {
				button.titleLabel?.font = AppFont.openSans_Regular.size(FontSize.h3)
				if let title = button.titleLabel?.text {
					button.setTitle(LocalizedString.localizedString(input: title), for: .normal)
				}
				button.addTarget(self, action: #selector(didButtonSelected), for: .touchUpInside)
				if button.tag == currentSelected {
					currentButton = button
				}
			}
		}
	}
	
	func setupTintColor(color: UIColor, unSelectedColor: UIColor = .lightGray) {
		tintColor = color
		defaultColor = unSelectedColor
		selectedView.backgroundColor = color
		prepareWith(selectedButton: currentButton)
	}
	
	func prepareWith(selectedButton: UIButton) {
		stackView.subviews.forEach { (view) in
			if let button = view as? UIButton {
				if button.tag != selectedButton.tag {
					button.setTitleColor(defaultColor, for: .normal)
					button.titleLabel?.font = AppFont.openSans_Regular.size(.h3)
				} else {
					button.setTitleColor(tintColor, for: .normal)
					button.titleLabel?.font = AppFont.openSans_Bold.size(.h3)
					UIView.animate(withDuration: 0.3, animations: {
						self.selectedView.frame = CGRect(x: button.frame.origin.x + 10, y: button.frame.size.height - 3, width: button.frame.size.width - 20, height: 3)
					})
				}
			}
		}
		currentButton = selectedButton
	}
	
	@objc private func didButtonSelected(sender: UIButton) {
		prepareWith(selectedButton: sender)
		valueChanged.onNext(sender.tag)
	}
}
