//
//  ASEUserInfoViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 12/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ASEUserInfoViewController: UserInfoViewController {
	// MARK: - ================================= Outlet =================================
	private weak var background: UserInfoBackgroundViewController!
	private weak var statistic: UserInfoStatisticViewController!
	private weak var detail: UserInfoDetailViewController!
	
	@IBOutlet private weak var detailHeightConstraint: NSLayoutConstraint!
	// MARK: - ================================= Properties =================================
	
	// MARK: - ================================= Init =================================
	override var isNavBarHidden: Bool {
		return false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		return findVC(from: segue.destination)
	}
	
	override func setupViews() {
		super.setupViews()
		
		transferInputs()
	}
	
	override func subcribeSetup() {
		super.subcribeSetup()
		
		detail
			.heightChanged
			.subscribe(onNext: { [weak self] detailHeight in
				self?.detailHeightConstraint.constant = CGFloat(detailHeight)
			})
			.disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config view =================================
	override func mainTitle() -> String {
		return LocalizedString.settingTittle()
	}
}

// MARK: - ================================= Private =================================
private extension ASEUserInfoViewController {
	func findVC(from destination: UIViewController) {
		switch destination {
		case is UserInfoBackgroundViewController:
			return background = destination as? UserInfoBackgroundViewController
		case is UserInfoStatisticViewController:
			return statistic = destination as? UserInfoStatisticViewController
		case is UserInfoDetailViewController:
			return detail = destination as? UserInfoDetailViewController
		default:
			break
		}
	}
	
	func transferInputs() {
		let inputBackground = UserInfoBackgroundViewInput(image: image)
		background.push(input: inputBackground)
		
		let inputStatistic = UserInfoStatisticViewInput()
		statistic.push(input: inputStatistic)
		
		let inputDetail = UserInfoDetailViewInput()
		return detail.push(input: inputDetail)
	}
}
