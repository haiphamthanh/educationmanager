//
//  DateTextField.swift
//  ASHManager
//
//  Created by ToanNV11 on 12/25/17.
//  Copyright © 2017 net.toan. All rights reserved.
//

import UIKit.UIButton

protocol DateTextFieldDelegate: class {
	func dateChange(textField: DateTextField, selectDate: String, selectedDateFull: String)
}

class DateTextField: UnderLineTextField {
	
	let datePicker = GKDateTimePicker()
	
	weak var dateTextFieldDelegate: DateTextFieldDelegate?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		datePicker.cutomizePickerDelegate = self
		
		allowsEditingTextAttributes = false
		text = datePicker.currentDate
		
		let toolbar = UIToolbar(frame: CGRect(x:0, y:0, width: 100, height: 35))
		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(GKDateTextField.doneButtonSelected(sender:)))
		
		toolbar.items = [doneButton]
		toolbar.tintColor = UIColor.white
		
		inputView = datePicker
		inputAccessoryView = toolbar
		delegate = self
	}
	
	override func caretRect(for: UITextPosition) -> CGRect {
		return CGRect.zero
	}
	
	@objc func doneButtonSelected(sender: UIButton) {
		resignFirstResponder()
	}
	
	func showPicker() {
		becomeFirstResponder()
	}
	
	func configTextFieldWithDateFull(withDayFull dateFull:String, pickerType: CutomizePickerType) {
		let components = dateFull.components(separatedBy: "/")
		if components.count != 3 {
			return
		}
		
		let year = NSInteger(components[0])
		let month = NSInteger(components[1])
		let day = NSInteger(components[2])
		
		datePicker.pickerType = pickerType
		datePicker.gotoDay(day: day!, month: month!, year: year!)
	}
}

extension DateTextField: UITextFieldDelegate {
	internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

extension DateTextField: CutomizePickerDelegate {
	@objc func cutomizePicker(in cutomizePicker: DateTimePicker, didSelectDate: String, selectedDateFull: String) {
		text = didSelectDate
		
		if ((dateTextFieldDelegate?.dateChange(textField: selectDate: selectedDateFull:)) != nil) {
			dateTextFieldDelegate?.dateChange(textField: self, selectDate: didSelectDate, selectedDateFull: selectedDateFull)
		}
	}
}
