//
//  LoadingViewController.swift
//  ASHManager
//
//  Created by TienNT12 on 6/7/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import NVActivityIndicatorView
import LTMorphingLabel
import SnapKit
import Schedule

enum LoadingType {
	case normal
	case network
	case loading
	
	func descriptions() -> [String] {
		switch self {
		case .network:
			return ["Lost connection", "Please wait for minute", "Thanks for helpful"]
		case .loading:
			return ["Oops", "Data loosing", "We got some proble", "Please wait for minute", "Thanks for helpful"]
		case .normal:
			return ["Loading.", "Loading..", "Loading...", "Loading....", "Loading....."]
		}
	}
	
	func indicatorType() -> NVActivityIndicatorType {
		switch self {
		case .network, .loading:
			return .pacman
		case .normal:
			return .ballTrianglePath
		}
	}
}

class LoadingViewController: UIViewController {
	// MARK: - ================================= Properties =================================
	private var labelIndex = 0
	private var loadingType: LoadingType = .network
	private var task: Task!
	
	// MARK: - ================================= Outlet =================================
	private let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
													type: NVActivityIndicatorType.pacman,
													color: MyColors.statusColor,
													padding: 0)
	private var descriptionTitle = LTMorphingLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
	
	// MARK: - ================================= Init =================================
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviewsTask()
		return setupLayoutTask()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		return runTask()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		return endTask()
	}
}

// MARK: - ================================= Usage list =================================
extension LoadingViewController {
	func change(type: LoadingType) {
		self.loadingType = type
	}
}

// MARK: - ================================= Private =================================
private extension LoadingViewController {
	// Set up tasks
	func setupSubviewsTask() {
		view.addSubview(descriptionTitle)
		return view.addSubview(indicator)
	}
	
	func setupLayoutTask() {
		descriptionTitle.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(100)
			make.center.equalTo(view)
		}
		
		indicator.snp.makeConstraints { (make) -> Void in
			make.centerX.equalTo(view)
			make.bottom.equalTo(descriptionTitle.snp.top).offset(20)
		}
	}
	
	// Run tasks
	func runTask() {
		switch loadingType {
		case .normal:
			setupViewForNormal()
		case .loading:
			setupViewForLoading()
		case .network:
			setupViewForNetwork()
		}
		
		indicator.type = loadingType.indicatorType()
		indicator.startAnimating()
		
		return animationLabelTexts()
	}
	
	func endTask() {
		task?.cancel()
		indicator.stopAnimating()
		
		// Restore to normal value
		labelIndex = 0
		return loadingType = .network
	}
	
	// Sub tasks
	func animationLabelTexts() {
		let descriptions = loadingType.descriptions()
		descriptionTitle.text = descriptions[0]
		labelIndex = 1
		
		return task = Plan.every(2.second).do { [weak self] in
			self?.startAnimationLabelPlan()
		}
	}
	
	func startAnimationLabelPlan() {
		let descriptions = loadingType.descriptions()
		let numberDesc = descriptions.count
		var currentIndex = labelIndex
		
		if currentIndex < numberDesc {
			let text = descriptions[currentIndex]
			descriptionTitle.text = text
			
			currentIndex += 1
		}
		
		if currentIndex == numberDesc {
			currentIndex = 0
		}
		
		// Update lable index
		return labelIndex = currentIndex
	}
}

// MARK: - Network =================================
private extension LoadingViewController {
	func setupViewForNetwork() {
		view.backgroundColor = MyColors.appColor
		descriptionTitle.morphingEffect = .scale
		
		return loadingType = .network
	}
}

// MARK: - Loading =================================
private extension LoadingViewController {
	func setupViewForLoading() {
		view.backgroundColor = MyColors.appColor
		descriptionTitle.morphingEffect = .scale
		
		return loadingType = .loading
	}
}

// MARK: - Normal =================================
private extension LoadingViewController {
	func setupViewForNormal() {
		view.backgroundColor = .clear
		descriptionTitle.morphingEffect = .evaporate
		
		return loadingType = .normal
	}
}
