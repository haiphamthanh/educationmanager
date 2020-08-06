//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import SwiftSoup

extension String {
	static func className(_ aClass: AnyClass) -> String {
		return NSStringFromClass(aClass).components(separatedBy: ".").last!
	}
	
	var htmlToAttributedString: NSAttributedString? {
		guard let data = data(using: .utf8) else { return NSAttributedString() }
		do {
			return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
		} catch {
			return NSAttributedString()
		}
	}
	
	var htmlToString: String {
		do {
			let doc: Document = try SwiftSoup.parse(self)
			return try doc.text()
		} catch Exception.Error(_, _) {
			print("")
		} catch {
			print("")
		}
		
		return self
	}
}
