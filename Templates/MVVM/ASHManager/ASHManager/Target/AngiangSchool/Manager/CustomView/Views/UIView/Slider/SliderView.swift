//
//  SliderView.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation
import EAIntroView

class SliderView: EAIntroView {
	func nextPage(animated: Bool) {
		let nextPage: UInt = currentPageIndex + 1
		if (nextPage >= pages.count) {
			if swipeToExit {
				hide(withFadeOutDuration: 0.3)
			}
		} else {
			scrollToPage(for: nextPage, animated: animated)
		}
	}
	
	func limitPage(at limitIndex: UInt) {
		scrollView.restrictionArea = CGRect(x: 0,
											y: 0,
											width: CGFloat(limitIndex) * scrollView.bounds.size.width,
											height: scrollView.bounds.size.height)
	}
}
