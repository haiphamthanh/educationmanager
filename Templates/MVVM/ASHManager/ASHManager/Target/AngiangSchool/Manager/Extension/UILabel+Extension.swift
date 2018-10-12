//
//  UILabel+Extension.swift
//  ASHManager
//
//  Created by NamPC on 2/12/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

extension UILabel {
	
	static var contestNormalFont: UIFont = AppFont.openSans_Regular.size(FontSize(rawValue: 12)!)
	static var contestBoldFontSize20: UIFont = AppFont.openSans_Bold.size(FontSize(rawValue: 20)!)
	static var contestSmallBoldFont: UIFont = AppFont.openSans_Bold.size(FontSize(rawValue: 10)!)
	static var contestRegularBoldFont: UIFont = AppFont.openSans_Bold.size(FontSize(rawValue: 12)!)
	static var contestStatusLargeBoldFont: UIFont = AppFont.openSans_Bold.size(FontSize(rawValue: 15)!)
	static var contestLargeBoldFont: UIFont = AppFont.openSans_Bold.size(FontSize(rawValue: 17)!)
	static var contestSemiBontFont: UIFont = AppFont.openSans_Semibold.size(FontSize(rawValue: 12)!)
	
	func setupFirstWord(color: UIColor) {
		let main_string = text!
		let string_to_color = text?.components(separatedBy: " ").first!
		
		let range = (main_string as NSString).range(of: string_to_color!)
		let attributedString = NSMutableAttributedString(string:main_string)
		
		attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
		attributedText = attributedString
	}
	
	func setupFirstWord(font: UIFont) {
		let main_string = text!
		let string_to_size = text?.components(separatedBy: " ").first!
		
		let range = (main_string as NSString).range(of: string_to_size!)
		let attributedString = NSMutableAttributedString(string:main_string)
		
		attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
		attributedText = attributedString
	}
	
	func setupFont(_ font: UIFont = contestNormalFont, textColor color: UIColor = .darkGray) {
		self.textColor = color
		self.font = font
	}
	
	func addImageWith(name: String, behindText: Bool) {
		
		let attachment = NSTextAttachment()
		attachment.image = UIImage(named: name)
		let attachmentString = NSAttributedString(attachment: attachment)
		
		guard let txt = self.text else {
			return
		}
		
		if behindText {
			let strLabelText = NSMutableAttributedString(string: txt)
			strLabelText.append(attachmentString)
			self.attributedText = strLabelText
		} else {
			let strLabelText = NSAttributedString(string: txt)
			let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
			mutableAttachmentString.append(strLabelText)
			self.attributedText = mutableAttachmentString
		}
	}
	
	func removeImage() {
		let text = self.text
		self.attributedText = nil
		self.text = text
	}
	
	func dropShadow(scale: Bool = true) {
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 1
		self.layer.shadowOffset = CGSize(width: 2, height: 1)
		self.layer.shadowRadius = 1.0
	}
}
