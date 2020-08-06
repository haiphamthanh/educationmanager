//
//  AbstractSlider.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/2/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import EAIntroView
import RxSwift

class SliderPresentationViewController: ViewControllerAdapter {
	// MARK: - ================================= Outlet =================================
	override var isNavBarHidden: Bool {
		return true
	}
	
	@IBOutlet weak var presentView: UIView!
}

class AbstractSlider: NSObject, EAIntroDelegate {
	// MARK: - ================================= Properties =================================
	private var viewModel: ViewModelAdapterProtocol?
	private(set) var sliderView: SliderView! {
		didSet {
			sliderDidSet()
		}
	}
	private(set) weak var vc: SliderPresentationViewController!
	private(set) weak var presentView: UIView?
	
	var disposeBag: DisposeBag {
		return vc.disposeBag
	}
	
	// MARK: - ================================= Config views =================================
	var minimumPageMargin: CGFloat {
		return 10 // Normal
	}
	var limitPage: Int = 2
	
	private var maxPage: UInt = 0 {
		didSet {
			sliderView.limitPage(at: maxPage + 1)
		}
	}
	func viewModelWraper<T>(type: T.Type) -> T {
		if let viewModel = viewModel as? T {
			return viewModel
		}
		
		fatalError("Need to assign viewmodel")
	}
	
	// MARK: - ======================================== Init ========================================
	required init(in vc: SliderPresentationViewController) {
		super.init()
		
		self.viewModel = vc.viewModelWraper(type: ViewModelAdapterProtocol.self)
		self.vc = vc
		if let view = vc.presentView {
			presentView = view
		} else {
			presentView = vc.view
		}
		
		self.initSliderView()
	}
	
	func sliderDidSet() {
		fatalError("Need implement in subclass")
	}
	
	func configView(with dataSource: Any) {
		fatalError("Need implement in subclass")
	}
	
	func introViewProvider() -> SliderView? {
		let listPages = listPagesBuilder()
		let intro = SliderView(frame: presentView!.bounds, andPages: listPages)
		intro?.skipButton.removeFromSuperview()
		intro?.delegate = self
		intro?.swipeToExit = false
		
		return intro
	}
	
	func listPagesBuilder() -> [EAIntroPage] {
		return [EAIntroPage]()
	}
	
	// MARK: - ================================= EAIntroDelegate =================================
	func intro(_ introView: EAIntroView!, pageAppeared page: EAIntroPage!, with pageIndex: UInt) {
	}
	
	func introWillFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
		// Move to login
	}
	
	func intro(_ introView: EAIntroView!, didScrollWithOffset offset: CGFloat) {
	}
	
	func intro(_ introView: EAIntroView!, pageStartScrolling page: EAIntroPage!, with pageIndex: UInt) {
		vc.view.endEditing(true)
	}
	
	func intro(_ introView: EAIntroView!, pageEndScrolling page: EAIntroPage!, with pageIndex: UInt) {
	}
}

// MARK: - ================================= Final =================================
extension AbstractSlider {
	func enableSlidePage(_ enable: Bool) {
		sliderView.scrollingEnabled = enable
	}
	
	func limit(at pageIndex: UInt) {
		maxPage = pageIndex
	}
	
	func noLimit() {
		maxPage = UInt(sliderView.pages.count)
	}
	
	func skip() {
		sliderView.nextPage(animated: true)
	}
	
	func skipAll() {
		sliderView.scrollToPage(for: maxPage, animated: false)
	}
}

// MARK: - ================================= PageControl =================================
private extension AbstractSlider {
	func initSliderView() {
		sliderView = introViewProvider()
		noLimit()
	}
}
