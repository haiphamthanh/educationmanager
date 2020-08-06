//
//  PopUpManager.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class PopUpManager {
	// MARK: - ================================= Properties =================================
	class var shared: PopUpManager {
		struct Static {
			static let instance = PopUpManager()
		}
		
		return Static.instance
	}
	
	// MARK: - ================================= Init =================================
	private init() {
	}
}

extension PopUpManager: PopUpProtocol {
	var photo: PopUpPhotoBehaviors {
		return PopUpPhotoViewController()
	}
}
