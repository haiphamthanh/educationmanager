//
//  CoordinatorAdapterSideMenu.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/21/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class CoordinatorAdapterSideMenu: BaseCoordinator<SideMenuType> {
	// MARK: - ================================= Side Menu =================================
	private lazy var sideMenu = SideMenuManager(presentView: viewController as! ViewControllerAdapterSideMenu,
												type: sideMenuType)
	var sideMenuType: SideMenuType {
		fatalError("Need to provide in subclass")
	}
	
	override var presentType: PresentType {
		return .updateRoot
	}
	
	override final func doAction(viewModel: BaseViewModelProtocol?) -> Observable<SideMenuType> {
		guard let viewModel = viewModel as? ViewModelAdapterSideMenuProtocol else {
			return Observable.never()
		}
		
		let showMenu = strongify(self, closure: { (instance, _: Void) in
			instance.sideMenu.showMenu()
		})
		
		let selectedMenu = { [weak self] (index: SideMenuType, point: CGPoint) -> SideMenuType in
			guard let instance = self else {
				return .home
			}
			
			instance.closedMenu(at: point)
			return index
		}
		
		viewModel.willShowMenu
			.subscribe(onNext: showMenu)
			.disposed(by: disposeBag)
		
		let customize = doActionCustomize(viewModel: viewModel)
		let selected = sideMenu.selected.map(selectedMenu)
		
		return Observable.merge(customize, selected)
			.take(1)
			.do(onNext: { _ in
			})
	}
	
	func doActionCustomize(viewModel: BaseViewModelProtocol?) -> Observable<SideMenuType> {
		fatalError("Need to be customize in subclass")
	}
	
	func closedMenu(at point: CGPoint) {
		navigationShouldAnimation(at: point)
	}
}
