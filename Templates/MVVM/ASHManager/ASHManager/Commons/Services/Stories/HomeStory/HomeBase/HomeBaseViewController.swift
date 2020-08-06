//
//  HomeBaseViewController.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class HomeBaseViewController: ViewControllerAdapterSideMenu {
	
	override func setupViews() {
		super.setupViews()
		
		if environmentDetected() == .development {
			var rightButtons = navigationItem.rightBarButtonItems
			let rightButton = UIBarButtonItem(barButtonSystemItem: .play,
											  target: self,
											  action: #selector(testingAction))
			rightButtons?.append(rightButton)
			
			navigationItem.rightBarButtonItems = rightButtons
		}
	}
}

extension HomeBaseViewController: HomeBaseViewProtocol {
}

// MARK: - ================================= private =================================
private extension HomeBaseViewController {
	@objc func testingAction() {
//		AppDelegate.shared()
//			.globalManager
//			.popup
//			.photo
//			.showPopup(.gallery)
//			.subscribe(onNext: { ouput in
//				print(ouput.image)
//			}, onDisposed: {
//				print("Did disposed")
//			})
//			.disposed(by: disposeBag)

		
		// Show galery
//		PopUpManager.shared
//			.showPhoto(.gallery)
//			.subscribe(onNext: { ouput in
//				print(ouput.location)
//			})
//			.disposed(by: disposeBag)
		
		// Show camera
//		let popup = PhotoPopupViewController()
//		popup.showPopup(.camera)
		
		let vc = UIViewController()
		navigationController?.pushViewController(vc)
		
	}
}
