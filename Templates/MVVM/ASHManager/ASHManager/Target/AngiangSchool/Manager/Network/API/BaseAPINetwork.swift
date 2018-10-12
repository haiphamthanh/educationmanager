//
//  BaseAPINetwork.swift
//  ASHManager
//
//  Created by HaiPT15 on 4/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class BaseAPINetwork {
	
	// MARK: - ================================= Auth =================================
	var token: String? {
		guard let token = Config.appToken() else {
			return nil
		}
		
		return token
	}
}
