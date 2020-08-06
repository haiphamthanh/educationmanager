//
//  ViewModelAdapterProtocol.swift
//  ASHManager
//
//  Created by 7i3u7u on 10/10/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol ViewModelAdapterProtocol: BaseViewModelProtocol {
	// MARK: View - Inputs
	// MARK: Coordinator - Outputs
	
	// MARK: View - Outputs
	var userCatched: Observable<UserData> { get }
	
	// MARK: Getter
	var userDisplayName: String { get }
	var accountInfo: (isSigned: Bool, user: UserData?) { get }
}
