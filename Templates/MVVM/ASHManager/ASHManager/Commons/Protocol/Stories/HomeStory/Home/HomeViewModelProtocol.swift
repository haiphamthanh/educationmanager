//
//  HomeViewModelProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

enum HomeTab: Int {
	case main = 0
	case news
	case video
}

protocol HomeDataProtocol {
	
}

class AbstractHomeData: HomeDataProtocol {
	
}

struct HomeFactoryData<T> {
	let tab: HomeTab
	let data: T
}

protocol HomeViewModelProtocol: HomeBaseViewModelProtocol {
	// MARK: View - Inputs
	// MARK: Coordinator - Outputs
}
