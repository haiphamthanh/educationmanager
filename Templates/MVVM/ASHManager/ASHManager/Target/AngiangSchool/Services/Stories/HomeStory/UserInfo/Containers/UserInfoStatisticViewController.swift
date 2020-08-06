//
//  UserInfoStatisticViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 12/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ViewData =================================
struct UserInfoStatisticViewInput {
	
}

// MARK: - Defination =================================
class UserInfoStatisticViewController: UIViewController {
}


// MARK: - Input =================================
extension UserInfoStatisticViewController {
	typealias Input = UserInfoStatisticViewInput
	
	func push(input: Input) {
		reloadView(with: input)
	}
}

// MARK: - Private =================================
private extension UserInfoStatisticViewController {
	func reloadView(with input: Input) {
	}
}
