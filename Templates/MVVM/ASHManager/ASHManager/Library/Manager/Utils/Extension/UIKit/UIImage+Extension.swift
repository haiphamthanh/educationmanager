//
//  UIIMage.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import Accelerate

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
	
	func resize(targetSize: CGSize) -> UIImage {
		let imageSize = size
		
		let widthRatio = targetSize.width / size.width
		let heightRatio = targetSize.height / size.height
		
		// Figure out what our orientation is, and use that to form the rectangle
		var newSize: CGSize
		if(widthRatio > heightRatio) {
			newSize = CGSize.init(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
		} else {
			newSize = CGSize.init(width: imageSize.width * widthRatio, height: imageSize.height * widthRatio)
		}
		
		if newSize.width > newSize.height {
			newSize.height = newSize.width
		} else {
			newSize.width = newSize.height
		}
		
		// This is the rect that we've calculated out and this is what is actually used below
		let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
		
		// Actually do the resizing to the rect using the ImageContext stuff
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
	
	func resizeImageUsingVImage(size: CGSize) -> UIImage? {
		let cgImage = self.cgImage!
		var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue), version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
		var sourceBuffer = vImage_Buffer()
		defer {
			free(sourceBuffer.data)
		}
		var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
		guard error == kvImageNoError else { return nil }
		// create a destination buffer
		let scale = self.scale
		let destWidth = Int(size.width)
		let destHeight = Int(size.height)
		let bytesPerPixel = self.cgImage!.bitsPerPixel/8
		let destBytesPerRow = destWidth * bytesPerPixel
		let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
		defer {
			destData.deallocate()
		}
		var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
		// scale the image
		error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
		guard error == kvImageNoError else { return nil }
		// create a CGImage from vImage_Buffer
		var destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
		guard error == kvImageNoError else { return nil }
		// create a UIImage
		let resizedImage = destCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: self.imageOrientation) }
		destCGImage = nil
		return resizedImage
	}
}
