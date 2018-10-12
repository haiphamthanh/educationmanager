//
//  CoordinatorProtocol.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/9/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

enum PresentType: Int {
	case push
	case present
}

/// Base abstract coordinator generic over the return type of the `start` method.
class BaseCoordinator<ResultType> {
	private var coorBag: AdapterCoordinator?
	
	/// Typealias which will allows to access a ResultType of the Coordainator by `CoordinatorName.CoordinationResult`.
	typealias CoordinationResult = ResultType
	
	/// Utility `DisposeBag` used by the subclasses.
	let disposeBag = DisposeBag()
	
	/// Unique identifier.
	private let identifier = UUID()
	
	/// Dictionary of the child coordinators. Every child coordinator should be added
	/// to that dictionary in order to keep it in memory.
	/// Key is an `identifier` of the child coordinator and value is the coordinator itself.
	/// Value type is `Any` because Swift doesn't allow to store generic types in the array.
	private var childCoordinators = [UUID: Any]()
	
	
	/// Stores coordinator to the `childCoordinators` dictionary.
	///
	/// - Parameter coordinator: Child coordinator to store.
	private func store<T>(coordinator: BaseCoordinator<T>) {
		childCoordinators[coordinator.identifier] = coordinator
	}
	
	/// Release coordinator from the `childCoordinators` dictionary.
	///
	/// - Parameter coordinator: Coordinator to release.
	private func free<T>(coordinator: BaseCoordinator<T>) {
		childCoordinators[coordinator.identifier] = nil
	}
	
	/// 1. Stores coordinator in a dictionary of child coordinators.
	/// 2. Calls method `start()` on that coordinator.
	/// 3. On the `onNext:` of returning observable of method `start()` removes coordinator from the dictionary.
	///
	/// - Parameter coordinator: Coordinator to start.
	/// - Returns: Result of `start()` method.
	func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
		store(coordinator: coordinator)
		return coordinator.start()
			.do(onNext: { [weak self] _ in
				self?.free(coordinator: coordinator)
			})
	}
	
	/// Starts job of the coordinator.
	///
	/// - Returns: Result of coordinator job.
	//	func start() -> Observable<ResultType> {
	//		fatalError("Start method should be implemented.")
	//	}
	var presentType: PresentType {
		return .push
	}
	
	func doAction(viewModel: BaseViewModelProtocol?) -> Observable<ResultType> {
		fatalError("Start method should be implemented.")
	}
	
	deinit {
		print("\(self) is deinit")
	}
}

extension BaseCoordinator {
	func start() -> Observable<ResultType> {
		if let vc = coorBag?.view as? UIViewController {
			if let window = coorBag?.window {
				// Config for root view
				let nav = coorBag?.navService.selectedNavigationController
				window.rootViewController = nav
				window.makeKeyAndVisible()
			} else {
				// Config for none root view
				switch presentType {
				case .push:
					coorBag?.navService.pushViewController(viewController: vc, animated: true)
				case .present:
					coorBag?.navService.presentViewController(viewController: vc, animated: true, completion: nil)
				}
			}
		}
		
		return doAction(viewModel: coorBag?.viewModel)
	}
	
	// Use for base to resolve instance Container+Extension.swift
	func setup(coorBag: AdapterCoordinator) {
		self.coorBag = coorBag
	}
	
	// Use for base to coordinate screen
	func push(params: Dictionary<String, Any>?) {
		coorBag?.viewModel.push(params: params)
	}
	
	// Use when finish the storyboard
	func doneStory(params: Dictionary<String, Any>?) -> Observable<Void> {
		if let rootNav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
			rootNav.viewControllers.removeAll()
		}
		
		return Observable.never()
	}
	
	// Back to previous
	func backToPreviousIfNeeded() {
		guard let vc = coorBag?.view as? UIViewController else {
			return
		}
		
		vc.navigationController?.popViewController(animated: true)
	}
}

class AdapterCoordinator {
	fileprivate let window: UIWindow?
	fileprivate weak var view: BaseViewProtocol!
	fileprivate let navService: BasicNavigationServiceProtocol
	fileprivate weak var viewModel: BaseViewModelProtocol!
	
	init(window: UIWindow? = nil,
		 viewModel: BaseViewModelProtocol,
		 view: BaseViewProtocol,
		 navService: BasicNavigationServiceProtocol) {
		self.window = window
		self.view = view
		self.viewModel = viewModel
		self.navService = navService
		
		guard let vc = view as? UIViewController, window != nil else {
			return
		}
		
		let navigation = GKExNavigationController(rootViewController: vc)
		navService.setupWithNavigationController(navigationController: navigation)
	}
	
	deinit {
		print("\(self) is deinit")
	}
	
	// Change if window is changed
	//	let navigation = GKExNavigationController(rootViewController: viewController)
	//	nav.setupWithNavigationController(navigationController: navigation)
	
	
	//	var appRegister: RegisterAppServiceProtocol {
	//		if let pAppRegister = pAppRegister {
	//			return pAppRegister
	//		}
	//
	//		fatalError("Miss for RegisterAppServiceProtocol for \(self)")
	//	}
	// No need to use view model for this time so that I will private this one
	//	private var viewModel: BaseViewModelProtocol {
	//		if let pViewModel = pViewModel {
	//			return pViewModel
	//		}
	//
	//		fatalError("Miss for BaseViewModelProtocol for \(self)")
	//	}
	//	var viewController: BaseViewController {
	//		if let pViewController = pViewController {
	//			return pViewController
	//		}
	//
	//		fatalError("Miss viewController for \(self)")
	//	}
	//	var navigationService: BasicNavigationServiceProtocol {
	//		if let pNavigationService = pNavigationService {
	//			return pNavigationService
	//		}
	//
	//		fatalError("Miss BasicNavigationServiceProtocol for \(self)")
	//	}
	//	var useAsRoot: Bool {
	//		return false
	//	}
	//
	//	private var pAppRegister: RegisterAppServiceProtocol!
	//	private var pViewModel: BaseViewModelProtocol!
	//	private var pViewController: BaseViewController!
	//	private var pNavigationService: BasicNavigationServiceProtocol!
	//
	//	private lazy let navigation = GKExNavigationController(rootViewController: viewController)
	//	private(set) var window: UIWindow?
	//	private(set) weak var delegate: BaseCoordinatorDelegate?
	
	// Option for init in subclass
	//	func initialize() {
	//	}
	
	//	override func start() -> Observable<T> {
	//		if isRoot, let window = window {
	//			// Warning: Don't bring to Initialize because we only need update navigation root if start coordinate
	//			pNavigationService.setupWithNavigationController(navigationController: navigation)
	//			window.rootViewController = navigation
	//			window.makeKeyAndVisible()
	//
	//			return Observable.never()
	//		}
	
	//		return pushToViewControler(viewController)
	//		return Observable<T>.never()
	//	}
}

//extension AdapterCoordinator: ViewModelCoordinatorDelegateAdapter {
//	func didTokenExpired(params: Dictionary<String, Any>?) -> Observable<Void> {
//		return coordinateToIntroduction()
//	}
//}

// MARK: - ########################## Final ##########################
//extension AdapterCoordinator: BaseCoordinatorProtocol {
//	func initialize(appRegister: RegisterAppServiceProtocol,
//					viewController: BaseViewController?,
//					navigationService: BasicNavigationServiceProtocol?,
//					window: UIWindow?) {
//		self.pAppRegister = appRegister
//		self.pViewController = viewController
//		self.pViewModel = viewController?.viewModelWraper(type: BaseViewModelProtocol.self)
//		self.pNavigationService = navigationService
//		self.window = window
//
//		initialize()
//	}
//
//	func setDelegate(_ delegate: BaseCoordinatorDelegate) {
//		self.delegate = delegate
//	}
//
//	func coordinateToIntroduction() -> Observable<Void> {
//		let introCoordinator = appRegister.introCoordinator()
//		return coordinate(to: introCoordinator)
//	}
//}

//// MARK: - ########################## Private ##########################
//private extension AdapterCoordinator {
//	func canByPassLogin() -> Bool {
//		let whiteList = [TermOfUseViewController.self,
//						 BasicInformationViewController.self,
//						 RecoverPasswordViewController.self,
//						 ResetPasswordViewController.self]
//
//		return whiteList.contains(where: { $0 == type(of: viewController) })
//	}
//}
//
//// MARK: - ########################## CoordinatorDelegate ##########################
//
//// MARK: ####### INTRODUCTION #######
//extension AdapterCoordinator: IntroCoordinatorDelegate {
//}
//
//// MARK: ####### REGISTER #######
//extension AdapterCoordinator: BasicInformationCoordinatorDelegate {
//}
//
//extension AdapterCoordinator: RegisterCoordinatorDelegate {
//	func didRegistedUser(params: Dictionary<String, Any>?) -> Observable<Void> {
//		return coordinateToHome(sender: self)
//	}
//}
//
//// MARK: ####### AUTH #######
//extension AdapterCoordinator: AuthCoordinatorDelegate {
//	var isLoggedIn: Bool {
//		return false
//	}
//
//	func didAuthenticated(params: Dictionary<String, Any>?) -> Observable<Void> {
//		return coordinateToHome(sender: self, params: params)
//	}
//}
//
//extension AdapterCoordinator: GKAuthCoordinatorDelegate {
//}
//
//// MARK: ####### TERM_OF_USE #######
//extension AdapterCoordinator: TermOfUseCoordinatorDelegate {
//}
//
//// MARK: ####### RECOVER_PASSWORD #######
//extension AdapterCoordinator: RecoverPasswordCoordinatorDelegate {
//}
//
//// MARK: ####### RESET_PASSWORD #######
//extension AdapterCoordinator: ResetPasswordCoordinatorDelegate {
//}
//
//// MARK: ####### HOME #######
//extension AdapterCoordinator: HomeCoordinatorDelegate {
//}
