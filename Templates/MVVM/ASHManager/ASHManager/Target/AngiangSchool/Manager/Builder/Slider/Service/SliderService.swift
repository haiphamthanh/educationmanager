//
//  SliderService.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/18/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class SliderService: SliderFactory {
	// MARK: - ================================= Properties =================================
	private var slider: AbstractSlider?
	
	// MARK: - ================================= Action =================================
	final func showIn(viewController: SliderPresentationViewController) {
		slider = resolve(vc: viewController)
		
		if let presentView = slider?.sliderView {
			if let view = viewController.presentView {
				presentView.show(in: view)
				return
			}
			
			presentView.show(in: viewController.view)
		}
	}
	
	final func configView(with dataSource: Any) {
		slider?.configView(with: dataSource)
	}
	
	// MARK: - ================================= Private =================================
	private func resolve(vc: SliderPresentationViewController) -> AbstractSlider? {
		let viewModel = vc.viewModelWraper(type: ViewModelAdapterProtocol.self)
		
		switch viewModel {
		case is IntroViewModelProtocol:
			return SliderIntro(in: vc)
		case is AccountRegisterViewModelProtocol:
			return SliderRegister(in: vc)
		default:
			return nil
		}
	}
}
