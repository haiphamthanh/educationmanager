//
//  BaseAppDelegate.swift
//  ASHManager
//
//  Created by HaiPT15 on 11/26/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift
import Swinject
import IQKeyboardManagerSwift
import Reachability
import UserNotifications

class BaseAppDelegate: UIResponder {
	// MARK: - ================================= Properties =================================
	//+++ Singleton ============
	class func shared<T: BaseAppDelegate>() -> T {
		return UIApplication.shared.delegate as! T
	}
	
	//+++ Internal ============
	private var pWindow: UIWindow?
	private var pContainer = Container()
	private let disposeBag = DisposeBag()
	
	//+++ Usage ============
	private var mainService: MainServiceProtocol!
	private var registerService: RegisterAppServiceProtocol!
	private var appCoordinator: AppCoordinatorProtocol!
	
	//Network checking ============
	private var networkVC: GKLoadingViewController?
	private var reachability: Reachability!
	
	// MARK: - ================================= initSystem =================================
	
	// 1. Register
	func register(container: Container, window: UIWindow) {
		container.register(MainServiceProtocol.self) { _ in BaseMainService() }
		container.register(RegisterAppServiceProtocol.self) { _ in BaseRegisterApp(container: container, window: window) }
	}
	
	// 2. initialize
	func initialize(container: Container) {
		mainService = container.sureResolve(MainServiceProtocol.self)
		registerService = container.sureResolve(RegisterAppServiceProtocol.self)
		appCoordinator = CoordinatorManager.appCoordinator()
		return reachability = Reachability()
	}
}

// MARK: - ================================= Extension =================================
extension BaseAppDelegate: UIApplicationDelegate, UNUserNotificationCenterDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		pWindow = UIWindow()
		
		initSystem(container: pContainer, window: pWindow!)
		return mainService.app(application, didFinishLaunchingWithOptions: launchOptions)
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		return mainService.appWillResignActive(application)
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		return mainService.appDidEnterBackground(application)
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		return mainService.appWillEnterForeground(application)
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		return mainService.appDidBecomeActive(application)
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		return mainService.appWillTerminate(application)
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return mainService.app(app, open: url, options: options)
	}
	
	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		return mainService.app(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
	}
}

// MARK: - ================================= Private =================================
extension BaseAppDelegate {
	var container: Container {
		return pContainer
	}
	
	var window: UIWindow? {
		return pWindow
	}
}

// MARK: - ================================= Private =================================
private extension BaseAppDelegate {
	func initSystem(container: Container, window: UIWindow) {
		registerTask(container: container, window: window)
		initTask(container: container)
		setupTask()
		
		return completionTask()
	}
	
	// Register Task ----------
	func registerTask(container: Container, window: UIWindow) {
		return register(container: container, window: window)
	}
	
	// Init Task ----------
	func initTask(container: Container) {
		return initialize(container: container)
	}
	
	// Setup Task ----------
	func setupTask() {
		setupKeyboard()
		return setupNetwork()
	}
	
	// Completion Task ----------
	func completionTask() {
		appCoordinator.start()
			.subscribe()
			.disposed(by: disposeBag)
	}
	
	// All sub Tasks --------------------------------------------------
	func setupKeyboard() {
		IQKeyboardManager.sharedManager().enable = true
		IQKeyboardManager.sharedManager().enableAutoToolbar = false
		IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
		IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = LocalizedString.doneButton()
	}
	
	func setupNetwork() {
		NotificationCenter
			.default
			.addObserver(self,
						 selector: #selector(networkDidChanged),
						 name: Notification.Name.reachabilityChanged,
						 object: nil)
		
		try? reachability.startNotifier()
		networkVC?.change(viewType: .network)
	}
	
	@objc func networkDidChanged(noti: Notification) {
		guard let root = UIApplication.shared.keyWindow?.rootViewController, let networkVC = self.networkVC else {
			return
		}
		
		let networkStatus = Reachability()?.connection ?? .none
		switch networkStatus {
		case .none:
			return root.present(networkVC, animated: true, completion: nil)
		default:
			return networkVC.dismiss(animated: true, completion: nil)
		}
	}
}
