//
//  ImageSlideShowUtil.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//
import UIKit
import RxSwift
import ImageSlideshow

final class ImageSlideShowUtil {
	private var viewController: UIViewController
	
	init(viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func setImageInputs(inputs: [InputSource], slideShow: ImageSlideshow, selector: Selector?) {
		initImageSlideShow(slideShow: slideShow, selector: selector)
		slideShow.setImageInputs(inputs)
	}
	
	func didTap(slideShow: ImageSlideshow) {
		let fullScreenController = slideShow.presentFullScreenController(from: self.viewController)
		// set the activity indicator for full screen controller (skipping the line will show no activity indicator)
		fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
	}
	
	private func initImageSlideShow(slideShow: ImageSlideshow, selector: Selector?) {
		slideShow.backgroundColor = UIColor.white
		slideShow.pageControlPosition = PageControlPosition.insideScrollView
		slideShow.pageControl.currentPageIndicatorTintColor = UIColor.black
		slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
		slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
		
		// optional way to show activity indicator during image load (skipping the line will show no activity indicator)
		slideShow.activityIndicator = DefaultActivityIndicator()
		
		// can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
		let recognizer = UITapGestureRecognizer(target: viewController, action: selector)
		slideShow.addGestureRecognizer(recognizer)
	}
}
