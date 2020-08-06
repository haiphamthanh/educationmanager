//
//  ViewModelAdapterSideMenu.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class ViewModelAdapterSideMenu: ViewModelAdapter {
	private let _menu = PublishSubject<Void>()
}

// MARK: - ================================= Inputs =================================
extension ViewModelAdapterSideMenu: ViewModelAdapterSideMenuProtocol {
	var showMenu: AnyObserver<Void> {
		return _menu.asObserver()
	}
}

// MARK: - ================================= Outputs =================================
extension ViewModelAdapterSideMenu {
	var willShowMenu: Observable<Void> {
		return _menu.asObserver()
	}
}
