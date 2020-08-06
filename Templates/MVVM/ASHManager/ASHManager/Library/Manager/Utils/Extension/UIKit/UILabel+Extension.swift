//
//  UILabel+Extension.swift
//  ASHManager
//
//  Created by NamPC on 2/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension UILabel {
	func setupFirstWord(font: UIFont, color: UIColor) {
		let main_string = text!
		let string_to_size = text?.components(separatedBy: " ").first!
		
		let range = (main_string as NSString).range(of: string_to_size!)
		let attributedString = NSMutableAttributedString(string:main_string)
		
		attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
		attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
		attributedText = attributedString
	}
	
	func addImageWith(name: String, behindText: Bool = true) {
		let attachment = NSTextAttachment()
		attachment.image = UIImage(named: name)
		let attachmentString = NSAttributedString(attachment: attachment)
		
		guard let text = self.text else {
			return
		}
		
		
		if behindText {
			let strLabelText = NSMutableAttributedString(string: text)
			strLabelText.append(attachmentString)
			return attributedText = strLabelText
		}
		
		let strLabelText = NSAttributedString(string: text)
		let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
		mutableAttachmentString.append(strLabelText)
		attributedText = mutableAttachmentString
	}
	
	func removeImage() {
		let text = self.text
		self.attributedText = nil
		self.text = text
	}
	
	func dropShadow(scale: Bool = true) {
		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 1
		layer.shadowOffset = CGSize(width: 2, height: 1)
		layer.shadowRadius = 1.0
	}
}
