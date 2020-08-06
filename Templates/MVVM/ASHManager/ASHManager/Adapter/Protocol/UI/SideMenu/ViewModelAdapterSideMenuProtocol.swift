//
//  ViewModelAdapterSideMenuProtocol.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/20/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol ViewModelAdapterSideMenuProtocol: ViewModelAdapterProtocol {
	// MARK: View - Inputs
	var showMenu: AnyObserver<Void> { get }
	
	// MARK: Coordinator - Outputs
	var willShowMenu: Observable<Void> { get }
}
