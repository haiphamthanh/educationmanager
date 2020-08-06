//
//  PresentTextField.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/1/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit.UIButton

struct PresentItem {
	var title: String
	var value: Any
}

protocol PresentTextFieldDataSource: class {
	func dataPresentProvider() -> [PresentItem]
}

protocol PresentTextFieldDelegate: class {
	func presentTextField(textField: PresentTextField, didSelected item: PresentItem)
}

class PresentTextField: UITextField {
	
	let picker = UIPickerView()
	private var componentWidth: CGFloat = 32
	
	weak var presentDataSource: PresentTextFieldDataSource?
	weak var presentDelegate: PresentTextFieldDelegate?
	private var data: [PresentItem]?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		allowsEditingTextAttributes = false
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		if let data = presentDataSource?.dataPresentProvider() {
			self.data = data
		}
		
		componentWidth = (frame.size.width * 50.0) / 100
		picker.dataSource = self
		picker.delegate = self
		inputView = picker
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
	
	func selectVlue(value: Any) {
		for i in 0..<data!.count {
			let item = data![i]
			if item.compare(value: value) {
				picker.delegate?.pickerView?(picker, didSelectRow: i, inComponent: 0)
				return
			}
		}
	}
}

extension PresentTextField: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if let data = data {
			return data.count
		}
		
		return 0
	}
}

extension PresentTextField: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if let data = data, data.count > 0 {
			return data[row].title
		}
		
		return nil
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		text = data![row].title
		presentDelegate?.presentTextField(textField: self, didSelected: data![row])
		resignFirstResponder()
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return componentWidth
	}
}

extension PresentItem {
	func compare(value: Any) -> Bool {
		if let valueOrigin = self.value as? String {
			return valueOrigin == (value as! String)
		}
		
		if let valueOrigin = self.value as? Int {
			return valueOrigin == (value as! Int)
		}
		
		if let valueOrigin = self.value as? BloodType {
			return valueOrigin == (value as! BloodType)
		}
		
		return false
	}
}
