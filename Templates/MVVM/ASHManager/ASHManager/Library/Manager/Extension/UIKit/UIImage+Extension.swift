//
//  UIIMage.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIImage {
	func trim(trimRect :CGRect) -> UIImage {
		if CGRect(origin: CGPoint.zero, size: self.size).contains(trimRect) {
			if let imageRef = self.cgImage?.cropping(to: trimRect) {
				return UIImage(cgImage: imageRef)
			}
		}
		
		UIGraphicsBeginImageContextWithOptions(trimRect.size, true, self.scale)
		self.draw(in: CGRect(x: -trimRect.minX, y: -trimRect.minY, width: self.size.width, height: self.size.height))
		let trimmedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let image = trimmedImage else { return self }
		
		return image
	}
	
	func maskWithColor(color: UIColor) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		let context = UIGraphicsGetCurrentContext()!
		let rect = CGRect(origin: CGPoint.zero, size: size)
		color.setFill()
		self.draw(in: rect)
		context.setBlendMode(.sourceIn)
		context.fill(rect)
		let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return resultImage
	}
}
