//
//  HomeVideoViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import SnapKit
import LTMorphingLabel

class HomeVideoViewController: ViewControllerAdapter {
	override var isNavBarHidden: Bool {
		return navigationController!.isNavigationBarHidden
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let label = LTMorphingLabel(text: "This is home video")
		view.addSubview(label)
		
		label.snp.makeConstraints { (make) -> Void in
			make.center.equalTo(view)
		}
	}
	
	override func configView(with dataSource: Any) {
		print("\(self) is choosen")
	}
}

extension HomeVideoViewController: HomeTabbarManagerProtocol {
	typealias T = HomeVideoData
	func reloadView(with input: T) {
	}
}
