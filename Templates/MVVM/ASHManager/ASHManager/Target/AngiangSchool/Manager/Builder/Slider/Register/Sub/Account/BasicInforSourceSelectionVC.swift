//
//  BasicInforSourceSelectionVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BasicInforSourceSelectionVC: AbstractBasicInforVC {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var lblDescription: GKHeaderLabel!
	@IBOutlet private weak var lblTitle: GKHeaderLabel!
	@IBOutlet private var sourceButtons: [UIButton]!
	
	private let pSourceSelected = PublishSubject<HealthSource>()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSetup()
		subcribeSetup()
	}
}

// MARK: - ================================= Final =================================
extension BasicInforSourceSelectionVC {
	var sourceSelected: Observable<HealthSource> {
		return pSourceSelected
	}
	
	func change(source: HealthSource) {
		return select(source: source)
	}
}

// MARK: - ================================= Private =================================
private extension BasicInforSourceSelectionVC {
	func subviewsSetup() {
		let number = sourceButtons.count
		let sources: [HealthSource] = [.gobe, .fitbit, .smartphone, .apple]
		
		for i in 0..<number {
			let button = sourceButtons[i]
			let source = sources[i]
			let desc = source.desc()
			
			button.backgroundColor = .clear
			button.tag = source.rawValue
			
			if let imageName = desc.image, let image = UIImage(named: imageName) {
				button.setImage(image, for: .normal)
			}
			
			if let title = desc.title {
				button.setTitle(title, for: .normal)
			}
			
			let success = strongify(self, closure: { (instance, tapGesture: UITapGestureRecognizer) in
				guard let tag = tapGesture.view?.tag, let source = HealthSource(rawValue: tag) else {
					return
				}
				
				instance.pSourceSelected.onNext(source)
			})
			
			button.rx
				.tapGesture()
				.when(.recognized)
				.subscribe(onNext: success)
				.disposed(by: disposeBag)
		}
		
		lblTitle.text = LocalizedString.deviceTitle()
		lblDescription.text = LocalizedString.deviceDescriptionTitle()
	}
	
	func subcribeSetup() {
	}
	
	func select(source: HealthSource) {
		for button in sourceButtons {
			if button.tag != source.rawValue {
				button.backgroundColor = .clear
				continue
			}
			
			button.backgroundColor = .gray
		}
	}
}
