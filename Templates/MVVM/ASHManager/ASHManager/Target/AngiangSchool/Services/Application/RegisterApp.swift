//
//  RegisterApp.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/9/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Swinject

class RegisterApp: BaseRegisterApp {
	// MARK: - ================================= Properties =================================
	// MARK: - ================================= Initialize =================================
	//	override func configHomeViewController(homeVC: inout UIViewController?, isSliderEnable: Bool = true) {
	//		super.configHomeViewController(homeVC: &homeVC, isSliderEnable: false)
	//	}
	
	// MARK: - ================================= Register =================================
	override func registerUsageServiceTo(container: Container) {
		super.registerUsageServiceTo(container: container)
		
		//		container.register(MenuServiceProtocol.self) { _ in MenuService() }
		//		container.register(LeftMenuDataServiceProtocol.self) { _ in LeftMenuDataService() }
		
		// Network
		container.register(UseCaseProviderProtocol.self) { _ in NetUseCaseProvider() }
		container.register(NetworkServiceProtocol.self) { r in
			let useCaseProviderService = r.sureResolve(UseCaseProviderProtocol.self)
			return NetworkManager(netUseCaseProvider: useCaseProviderService)
		}
	}
	
	override func registerGUITo(container: Container, window: UIWindow) {
		super.registerGUITo(container: container, window: window)
		
		//MARK: ------------------------------------ APPLICATION ------------------------------------
		container.register(AppCoordinatorProtocol.self) { _ in AppCoordinator() }
		
		//MARK: ------------------------------------ REGISTER ------------------------------------
		// Driver
		container.register(RegisterCoordinatorProtocol.self) { _ in RegisterCoordinator() }
		
		// User Info Registration
		container.register(AccountRegisterModelProtocol.self) { _ in AccountRegisterModel() }
		container.register(AccountRegisterViewModelProtocol.self) { _ in
			let model = container.sureResolve(AccountRegisterModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = AccountRegisterViewModel(model: model,
													 networkService: network)
			
			return viewModel
		}
		container.register(AccountRegisterViewProtocol.self) { _ in AccountRegisterViewController.newInstance() }
		container.register(AccountRegisterCoordinatorProtocol.self) { r in
			let view = r.sureResolve(AccountRegisterViewProtocol.self)
			let viewModel = r.sureResolve(AccountRegisterViewModelProtocol.self)
			let coordinator = AccountRegisterCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator, window: window)
		}
		
		//MARK: ------------------------------------ INTRODUCTION ------------------------------------
		container.register(IntroModelProtocol.self) { _ in IntroModel() }
		container.register(IntroViewModelProtocol.self) { _ in
			let model = container.sureResolve(IntroModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = IntroViewModel(model: model,
										   networkService: network)
			
			return viewModel
		}
		container.register(IntroViewProtocol.self) { _ in IntroViewController.newInstance() }
		container.register(IntroCoordinatorProtocol.self) { r in
			let view = r.sureResolve(IntroViewProtocol.self)
			let viewModel = r.sureResolve(IntroViewModelProtocol.self)
			let coordinator = IntroCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator, window: window)
		}
		
		//MARK: ------------------------------------ AUTHENTICATION ------------------------------------
		container.register(AuthModelProtocol.self) { _ in GKAuthModel() }
		container.register(AuthViewModelProtocol.self) { _ in
			let model = container.sureResolve(AuthModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = GKAuthViewModel(model: model,
											networkService: network)
			
			return viewModel
		}
		container.register(AuthViewProtocol.self) { _ in GKAuthViewController.newInstance() }
		container.register(AuthCoordinatorProtocol.self) { r in
			let view = r.sureResolve(AuthViewProtocol.self)
			let viewModel = r.sureResolve(AuthViewModelProtocol.self)
			let coordinator = GKAuthCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator)
		}
		
		//MARK: #################### TERM_OF_USE ####################
		container.register(TermOfUseModelProtocol.self) { _ in TermOfUseModel() }
		container.register(TermOfUseViewModelProtocol.self) { _ in
			let model = container.sureResolve(TermOfUseModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = TermOfUseViewModel(model: model,
											   networkService: network)
			
			return viewModel
		}
		container.register(TermOfUseViewProtocol.self) { _ in TermOfUseViewController.newInstance() }
		container.register(TermOfUseCoordinatorProtocol.self) { r in
			let view = r.sureResolve(TermOfUseViewProtocol.self)
			let viewModel = r.sureResolve(TermOfUseViewModelProtocol.self)
			let coordinator = TermOfUseCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator)
		}
		
		//MARK: #################### RECOVER_PASSWORD ####################
		container.register(RecoverPasswordModelProtocol.self) { _ in RecoverPasswordModel() }
		container.register(RecoverPasswordViewModelProtocol.self) { _ in
			let model = container.sureResolve(RecoverPasswordModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = RecoverPasswordViewModel(model: model,
													 networkService: network)
			
			return viewModel
		}
		container.register(RecoverPasswordViewProtocol.self) { _ in RecoverPasswordViewController.newInstance() }
		container.register(RecoverPasswordCoordinatorProtocol.self) { r in
			let view = r.sureResolve(RecoverPasswordViewProtocol.self)
			let viewModel = r.sureResolve(RecoverPasswordViewModelProtocol.self)
			let coordinator = RecoverPasswordCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator)
		}
		
		//MARK: #################### RESET_PASSWORD ####################
		container.register(ResetPasswordModelProtocol.self) { _ in ResetPasswordModel() }
		container.register(ResetPasswordViewModelProtocol.self) { _ in
			let model = container.sureResolve(ResetPasswordModelProtocol.self)
			
			// Config for network
			let network = container.sureResolve(NetworkServiceProtocol.self)
			let viewModel = ResetPasswordViewModel(model: model,
												   networkService: network)
			
			return viewModel
		}
		container.register(ResetPasswordViewProtocol.self) { _ in ResetPasswordViewController.newInstance() }
		container.register(ResetPasswordCoordinatorProtocol.self.self) { r in
			let view = r.sureResolve(ResetPasswordViewProtocol.self)
			let viewModel = r.sureResolve(ResetPasswordViewModelProtocol.self)
			let coordinator = ResetPasswordCoordinator()
			
			return r.promiseCoordinator(view: view, viewModel: viewModel, coordinator: coordinator)
		}
	}
}
