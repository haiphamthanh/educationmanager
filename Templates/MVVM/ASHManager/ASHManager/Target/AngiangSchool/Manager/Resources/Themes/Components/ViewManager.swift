//
//  ViewManager.swift
//  ASHManager
//
//  Created by 7i3u7u on 2018/02/19.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

/// Used screens
///
class GKCountdownView: CountdownView {
}

/// Used screens
///
class GKIndicatorView: IndicatorView {
}

/// Used screens
///
class GKImageHeaderView : ImageHeaderView {
}

/// Used screens
///
class GKSliderView: SliderView {
}

/// Used screens
///
class GKSliderPageView: SliderPageView {
	// TODO: HaiPT15
	func add(vc: UIViewController) {
		
	}
}


//extension Reactive where Base: SVProgressHUD {
//
//	public static var isAnimating: Binder<Bool> {
//		return Binder(UIApplication.shared) {progressHUD, isVisible in
//			if isVisible {
//				SVProgressHUD.show()
//			} else {
//				SVProgressHUD.dismiss()
//			}
//		}
//	}
//
//}

