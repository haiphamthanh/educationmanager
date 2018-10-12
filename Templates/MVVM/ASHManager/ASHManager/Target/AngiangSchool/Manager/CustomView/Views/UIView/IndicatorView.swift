//
//  IndicatorView.swift
//  ASHManager
//
//  Created by PhanDuyHai on 1/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import NVActivityIndicatorView

class IndicatorView {
	static let shared = IndicatorView()
	private var isShowing = false
	
	var indicator = NVActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 60,height: 60))
	var containerView = UIView()
	
	func show() {
		show(nil)
	}
	
	func show(_ view: UIView?) {
		if isShowing {
			return
		} else {
			var viewShowing = view
			if viewShowing == nil {
				if let rootView = rootView() {
					viewShowing = rootView
					print(viewShowing!.frame)
				} else {
					return
				}
			}

			containerView.frame = viewShowing!.frame
			containerView.center = viewShowing!.center
			containerView.backgroundColor = UIColor(white: 0x000000, alpha: 0.2)
			
			indicator.color = Color.genkiorange.value
			indicator.type = .ballScaleMultiple
			indicator.center = CGPoint(x: viewShowing!.bounds.width/2,y: viewShowing!.bounds.height/2)
			indicator.startAnimating()
			containerView.addSubview(indicator)
			
			viewShowing!.addSubview(containerView)
			isShowing = true
		}
	}
	
	private func rootView() -> UIView?{
		return UIApplication.topView()
	}
	
	func hide() {
		if !isShowing {
			return
		}
		
		indicator.stopAnimating()
		containerView.removeFromSuperview()
		isShowing = false
	}
}
