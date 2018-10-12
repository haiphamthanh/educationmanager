//
//  Intro.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import EAIntroView
import Accelerate

class Intro: UIView {
	// MARK: - ================================= Properties =================================
	@IBOutlet private weak var backgroundImageView: UIImageView!
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var titleIntroLabel: UILabel!
	@IBOutlet private weak var contentTitleLabel: UILabel!
	@IBOutlet private weak var contentIntroLabel: UILabel!
	
	// MARK: - ================================= Init =================================
	override func awakeFromNib() {
		super.awakeFromNib()
		
		initView()
	}
	
	// MARK: - ================================= Action =================================
	final func configView(bgImage: String,
						  iconImage: String,
						  introTitle: String,
						  contentTitle: String,
						  contentIntro: String) {
		if let bgImage = UIImage(named: bgImage) {
			backgroundImageView.image = bgImage.resize(targetSize: frame.size)
		}
		
		if let iconImage = UIImage(named: iconImage) {
			iconImageView.image = iconImage
		}
		
		titleIntroLabel.text = introTitle
		contentTitleLabel.text = contentTitle
		contentIntroLabel.text = contentIntro
	}
	
	final func configView(introTitleTextColor: UIColor?,
						  contentTitleTextColor: UIColor? = .white,
						  contentIntroTextColor: UIColor? = .white) {
		if let color = introTitleTextColor {
			titleIntroLabel.textColor = color
		}
		
		contentTitleLabel.textColor = contentTitleTextColor
		contentIntroLabel.textColor = contentIntroTextColor
	}
	
	final func configIntroShadow() {
		contentIntroLabel.removeShadow()
	}
	
	// MARK: - ================================= Private =================================
	private func initView() {
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		
		iconImageView.contentMode = .scaleAspectFit
		iconImageView.clipsToBounds = true
		
		titleIntroLabel.font = AppFont.openSans_Bold.size(.introTitleSize)
		titleIntroLabel.textColor = UIColor.colorWithHex(AppColor.primary)
		titleIntroLabel.textAlignment = .center
		
		contentTitleLabel.font = AppFont.openSans_Bold.size(.introContentSize)
		contentTitleLabel.textColor = .white
		contentTitleLabel.textAlignment = .center
		contentIntroLabel.textColor = .white
		contentIntroLabel.dropShadow()
		contentIntroLabel.textAlignment = .center
		
		if (Device.isJapanLanguage) {
			contentIntroLabel.font = AppFont.meiryob.size(.introContentSize)
		} else {
			contentIntroLabel.font = AppFont.openSans_Regular.size(.introContentSize)
		}
	}
}

// Prefer: https://medium.com/@nishantnitb/resize-image-with-swift-4-ca17d65bbc85
extension UIImage {
	func resize(targetSize: CGSize) -> UIImage {
		let widthRatio  = targetSize.width  / size.width
		let heightRatio = targetSize.height / size.height
		
		// Figure out what our orientation is, and use that to form the rectangle
		var newSize: CGSize
		if(widthRatio > heightRatio) {
			newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
		} else {
			newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
		}
		
		if #available(iOS 10.0, *) {
			return UIGraphicsImageRenderer(size:newSize).image { _ in
				self.draw(in: CGRect(origin: .zero, size: newSize))
			}
		} else {
			return self
		}
	}
	
	func resizeImageUsingVImage(size:CGSize) -> UIImage? {
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
