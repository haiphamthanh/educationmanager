//
//  BasicInforAvatarVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import Kingfisher
import SwifterSwift

class BasicInforAvatarVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var avatarImageView: UIImageView!
	
	private let pImageSelected = PublishSubject<Data>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforAvatarVC {
	var imageSelected: Observable<Data> {
		return pImageSelected
	}
	
	func selected(avatar: String) {
		guard !avatar.isValidUrl else {
			return
		}
		
		let imageUrl = URL(string: "\(avatar)")
		avatarImageView.kf.setImage(with: imageUrl)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforAvatarVC {
	func subviewsSetup() {
		titleLabel.text = LocalizedString.choosePicTitle()
	}
	
	func subcribeSetup() {
	}
}
