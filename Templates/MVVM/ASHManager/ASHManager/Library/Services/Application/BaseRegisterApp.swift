//
//  BaseRegisterApp.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/9/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

// MARK: - ================================= All Service is provided =================================
//var mainService: MainServiceProtocol { get }
//var menuService: MenuServiceProtocol { get }
//var authService: AuthServiceProtocol { get }
//var networkService: NetworkServiceProtocol { get }
//var pageDialogService: PageDialogServiceProtocol { get }
//var toastService: ToastServiceProtocol { get }
//var leftMenuDataService: LeftMenuDataServiceProtocol { get }
//var leftMenuActionService: LeftMenuActionServiceProtocol { get }
//var appCoordinatorService: AppCoordinatorProtocol { get }
//var dataStoreService: DataStoreProtocol { get }
//var navService: BasicNavigationServiceProtocol { get }

class BaseRegisterApp: RegisterAppServiceProtocol {
	// MARK: - ================================= Private Properties =================================
	private weak var container: Container!
	private weak var window: UIWindow!
	
	// MARK: - ================================= Initialize =================================
	//+++ DependencyService =======
	init(container: Container, window: UIWindow) {
		self.container = container
		self.window = window
		
		// Register
		self.registerTo(container: container, window: window)
	}
	
	// MARK: - ================================= Register =================================
	func registerMainServiceTo(container: Container) {
		container.register(BasicNavigationServiceProtocol.self) { [unowned self] _ in
			return BasicNavigationService.init(from: self.window)
		}
	}
	
	func registerUsageServiceTo(container: Container) {
		container.register(NetworkServiceProtocol.self) { _ in BaseNetworkService() }
		container.register(PageDialogServiceProtocol.self) { _ in BasePageDialogService() }
		container.register(ToastServiceProtocol.self) { _ in BaseToastService() }
	}
	
	func registerGUITo(container: Container, window: UIWindow) {
		//MARK: ------------------------------------ APPLICATION ------------------------------------
		container.register(AppCoordinatorProtocol.self) { _ in BaseAppCoordinator() }
		
		//MARK: ------------------------------------ AUTHENTICATION ------------------------------------
		container.register(AuthModelProtocol.self) { _ in AuthModel() }
		container.register(AuthViewModelProtocol.self) { _ in
			let model = container.sureResolve(AuthModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = AuthViewModel(model: model,
										  networkService: network)
			
			return viewModel
		}
		container.register(AuthViewProtocol.self) { _ in AuthViewController.newInstance() }
		container.register(AuthCoordinatorProtocol.self) { r in
			let view = r.sureResolve(AuthViewProtocol.self)
			let viewModel = r.sureResolve(AuthViewModelProtocol.self)
			let coordinator = AuthCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator)
		}
		
		//MARK: ------------------------------------ HOME ------------------------------------
		//		container.register(HomeModelProtocol.self) { _ in HomeModel() }
		//		container.register(HomeViewModelProtocol.self) { _ in HomeViewModel() }
		//		container.register(HomeCoordinatorProtocol.self) { _ in HomeCoordinator() }
		//		container.register(HomeViewModelViewProtocol.self) { _ in
		//			HomeViewController.newInstance()
		//		}
	}
}

// MARK: - ================================= Private =================================
private extension BaseRegisterApp {
	func registerTo(container: Container, window: UIWindow) {
		registerMainServiceTo(container: container)
		registerUsageServiceTo(container: container)
		registerGUITo(container: container, window: window)
	}
}
