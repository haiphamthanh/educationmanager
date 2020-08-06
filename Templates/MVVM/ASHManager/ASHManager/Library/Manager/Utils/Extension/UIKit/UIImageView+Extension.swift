//
//  UIImageView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/3/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIImageView {
	func clipParallaxEffect(_ baseImage: UIImage?, screenSize: CGSize, displayHeight: CGFloat) {
		if let baseImage = baseImage {
			if displayHeight < 0 {
				return
			}
			let aspect: CGFloat = screenSize.width / screenSize.height
			let imageSize = baseImage.size
			let imageScale: CGFloat = imageSize.height / screenSize.height
			
			let cropWidth: CGFloat = floor(aspect < 1.0 ? imageSize.width * aspect : imageSize.width)
			let cropHeight: CGFloat = floor(displayHeight * imageScale)
			
			let left: CGFloat = (imageSize.width - cropWidth) / 2
			let top: CGFloat = (imageSize.height - cropHeight) / 2
			
			let trimRect : CGRect = CGRect(x: left, y: top, width: cropWidth, height: cropHeight)
			self.image = baseImage.trim(trimRect: trimRect)
			self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: displayHeight)
		}
	}
	
	static func imageNameFromImageURL(imageURL: NSURL?) -> String? {
		return imageURL?.lastPathComponent
	}
	
	static func imageContentTypeFromImageURL(imageURL: NSURL?) -> String {
		var contentType = "image/png"
		if (imageURL?.pathExtension?.lowercased() == "jpg") {
			contentType = "image/jpg"
		}
		
		return contentType
	}
}
