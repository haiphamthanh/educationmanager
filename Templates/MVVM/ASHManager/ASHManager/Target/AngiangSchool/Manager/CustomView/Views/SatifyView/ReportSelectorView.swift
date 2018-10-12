
//
//  ReportSelectorView.swift
//  ASHManager
//
//  Created by KhoaLA on 4/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum SatifySelector: Int {
	case low = 1
	case medium
	case high
	case critical
}

class ReportSelectorView: UIView {

	@IBOutlet weak var btnLow: CircleBorderButtom!
	@IBOutlet weak var btnMedium: CircleBorderButtom!
	@IBOutlet weak var btnHigh: CircleBorderButtom!
	@IBOutlet weak var btnCritical: CircleBorderButtom!
	
	@IBOutlet weak var lowLabel: UILabel!
	@IBOutlet weak var mediumLabel: UILabel!
	@IBOutlet weak var highLabel: UILabel!
	@IBOutlet weak var criticalLabel: UILabel!
	
	var selected: SatifySelector = .medium
	private let  selectedColor = UIColor.orange
	private let  commonColorBorder = UIColor.lightGray
	private let  commonColorBG = UIColor.white
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
		
		lowLabel.text = LocalizedString.localizedString(input: "Report_Bug_Low_Level")
		mediumLabel.text = LocalizedString.localizedString(input: "Report_Bug_Medium_Level")
		highLabel.text = LocalizedString.localizedString(input: "Report_Bug_High_Level")
		criticalLabel.text = LocalizedString.localizedString(input: "Report_Bug_Critical_Level")
	}

	private func setup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = self.bounds
		addSubview(view)
	}
	
	private func loadViewFromNib() -> UIView? {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "ReportSelector", bundle: bundle)
		return nib.instantiate(withOwner: self, options: nil).first as? UIView
	}
	
	@IBAction func btnLowTapped(_ sender: Any) {
		selected = .low
		let buttons: [CircleBorderButtom] = [btnMedium, btnHigh, btnCritical]
		changeChangeSelector(selected: btnLow, other: buttons)
	}
	
	@IBAction func btnMediumTapped(_ sender: Any) {
		selected = .medium
		let buttons: [CircleBorderButtom] = [btnLow, btnHigh, btnCritical]
		changeChangeSelector(selected: btnMedium, other: buttons)
	}
	
	@IBAction func btnHighTapped(_ sender: Any) {
		selected = .high
		let buttons: [CircleBorderButtom] = [btnLow, btnMedium, btnCritical]
		changeChangeSelector(selected: btnHigh, other: buttons)
	}
	
	@IBAction func btnCriticalTapped(_ sender: Any) {
		selected = .critical
		let buttons: [CircleBorderButtom] = [btnLow, btnMedium, btnHigh]
		changeChangeSelector(selected: btnCritical, other: buttons)
	}
	
	func reset() {
		changeChangeSelector(selected: btnMedium, other: [btnLow, btnHigh, btnCritical])
	}
	
	private func changeChangeSelector(selected: CircleBorderButtom, other: [CircleBorderButtom]) {
		selected.btnBorderColor = selectedColor
		selected.backgroundColor = selectedColor
		
		for btn in other {
			btn.btnBorderColor = commonColorBorder
			btn.background = commonColorBG
		}
	}
}
