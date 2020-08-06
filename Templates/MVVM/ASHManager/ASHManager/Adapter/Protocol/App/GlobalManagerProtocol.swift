//
//  GlobalManagerProtocol.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/18/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

protocol GlobalManagerProtocol {
	var appSetup: AppSetupProtocol { get }
	var loadingView: LoadingManagerProtocol { get }
	var account: AccountManagerProtocol { get }
	var popup: PopUpProtocol { get }
}
