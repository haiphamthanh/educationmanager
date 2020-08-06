//
//  SliderIntro.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import EAIntroView

class SliderIntro: AbstractSlider {
	// MARK: - ================================= Config views =================================
	private var viewModel: IntroViewModelProtocol? {
		return viewModelWraper(type: IntroViewModelProtocol.self)
	}
	
	override func listPagesBuilder() -> [EAIntroPage] {
		return listPagesProvider()
	}
	
	// MARK: - ======================================== Init ========================================
	override func sliderDidSet() {
		// Do nothing
	}
}

// MARK: - ================================= Private =================================
extension SliderIntro {
	private func listPagesProvider() -> [EAIntroPage] {
		var listPages = [EAIntroPage]()
		
		let images = vc.image.intros
		let logo = vc.image.logo
		let title = LocalizedString.titleIntroduct()
		let header = LocalizedString.titleHeadingIntroduct()
		let contents = [LocalizedString.contentIntroduct(),
						LocalizedString.contentIntroduct1(),
						LocalizedString.contentIntroduct2(),
						LocalizedString.contentIntroduct3(),
						LocalizedString.contentIntroduct4(),
						LocalizedString.contentIntroduct5()]
		
		// MARK: ========= PROFILE ==================
		let count = images.count
		for i in 0..<count {
			let introView = Intro.loadNib()
			
			let image = images[i]
			let content = contents[i]
			
			let slideImage = (bg: image, icon: logo)
			let text = (title: title, header: header, content: content)
			
			introView.configView(image: slideImage,
								 text: text)
			
			listPages.append(EAIntroPage.init(customView: introView))
		}
		
		return listPages
	}
}
