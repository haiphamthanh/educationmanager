//
//  Intro.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit

class Intro: UIView {
	// MARK: - ================================= Properties =================================
	@IBOutlet private weak var backgroundImageView: UIImageView!
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var titleIntroLabel: UILabel!
	@IBOutlet private weak var contentTitleLabel: UILabel!
	@IBOutlet private weak var contentIntroLabel: UILabel!
	
	// MARK: - ================================= Init =================================
	override func awakeFromNib() {
		super.awakeFromNib()
		
		initView()
	}
	
	// MARK: - ================================= Action =================================
	final func configView(image: (bg: UIImage, icon: UIImage),
						  text: (title: String, header: String, content: String)) {
		
		backgroundImageView.image = image.bg.resize(targetSize: frame.size)
		iconImageView.image = image.icon
		
		titleIntroLabel.text = text.title
		contentTitleLabel.text = text.header
		contentIntroLabel.text = text.content
	}
	
	// MARK: - ================================= Private =================================
	private func initView() {
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		
		iconImageView.contentMode = .scaleAspectFit
		iconImageView.clipsToBounds = true
		
		titleIntroLabel.textColor = MyColors.textColor
		titleIntroLabel.textAlignment = .center
		
		contentTitleLabel.textColor = MyColors.textColor
		contentTitleLabel.textAlignment = .center
		
		contentIntroLabel.textColor = MyColors.textColor
		contentIntroLabel.dropShadow()
		contentIntroLabel.textAlignment = .center
	}
}
