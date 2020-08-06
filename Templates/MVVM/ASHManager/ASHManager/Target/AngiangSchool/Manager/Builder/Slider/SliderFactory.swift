//
//  SliderFactory.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

protocol SliderFactory {
	// Action
	func showIn(viewController: SliderPresentationViewController)
	func configView(with dataSource: Any)
}
