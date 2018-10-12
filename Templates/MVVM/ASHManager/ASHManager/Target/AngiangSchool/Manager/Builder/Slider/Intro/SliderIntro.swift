//
//  SliderIntro.swift
//  ASHManager
//
//  Created by HaiPT15 on 1/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import SMPageControl
import EAIntroView

class SliderIntro: AbstractSlider {
	// MARK: - ================================= Config views =================================
	override var pageControlImage: UIImage {
		return UIImage(named: "ic_Intro_PageControl_UnSelected")!
	}
	override var currentPageControlImage: UIImage {
		return UIImage(named: "ic_Intro_PageControl_Selected")!
	}
	
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
		
		// MARK: ========= PROFILE ==================
		let intro1 = Intro.loadNib()
		intro1.configView(bgImage: "Intro_bg1",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct())
		let intro2 = Intro.loadNib()
		intro2.configView(bgImage: "Intro_bg2",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct1())
		let intro3 = Intro.loadNib()
		intro3.configView(bgImage: "Intro_bg3",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct2())
		let intro4 = Intro.loadNib()
		intro4.configView(bgImage: "Intro_bg4",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct3())
		let intro5 = Intro.loadNib()
		intro5.configView(bgImage: "Intro_bg5",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct4())
		let intro6 = Intro.loadNib()
		intro6.configView(bgImage: "Intro_bg6",
						  iconImage: "Intro_logo",
						  introTitle: LocalizedString.titleIntroduct(),
						  contentTitle: LocalizedString.titleHeadingIntroduct(),
						  contentIntro: LocalizedString.contentIntroduct5())
		intro6.configView(introTitleTextColor: nil, contentTitleTextColor: .darkGray, contentIntroTextColor: .black)
		intro6.configIntroShadow()
		let pages = [intro1, intro2, intro3, intro4, intro5, intro6]
		for page in pages {
			listPages.append(EAIntroPage.init(customView: page))
		}
		
		return listPages
	}
}
