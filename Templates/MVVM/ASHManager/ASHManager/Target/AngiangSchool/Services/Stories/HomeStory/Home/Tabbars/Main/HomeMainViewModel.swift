//
//  HomeMainViewModel.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class HomeMainData: AbstractHomeData {
	var mainName: String?
}

class HomeMainViewModel: ViewModelAdapter {
	override func initialize(params: Dictionary<String, Any>?) {
		super.initialize(params: params)
		
		refreshData()
	}
	
	override func mergedData() -> Any? {
		return ""
	}
}
