//
//  UserInfoBackgroundViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 12/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ViewData =================================
struct UserInfoBackgroundViewInput {
	let image: ImageServiceProtocol
}

// MARK: - Defination =================================
class UserInfoBackgroundViewController: UIViewController {
	@IBOutlet private weak var avatarImageView: UIImageView!
}


// MARK: - Input =================================
extension UserInfoBackgroundViewController {
	typealias Input = UserInfoBackgroundViewInput
	
	func push(input: Input) {
		reloadView(with: input)
	}
}

// MARK: - Private =================================
private extension UserInfoBackgroundViewController {
	func reloadView(with input: Input) {
		avatarImageView.image = input.image.avatar
	}
}
