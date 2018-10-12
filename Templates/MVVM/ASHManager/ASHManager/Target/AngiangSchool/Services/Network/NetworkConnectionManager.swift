//
//  NetworkConnectionManager.swift
//  ASHManager
//
//  Created by HieuNT52-MC on 4/2/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation
import Reachability


final class NetworkConnectionManager: NSObject {
	
	enum Status<Connection> {
		case available(Connection?)
		case unavailable
	}
	
	private let hostName = "http://10.88.16.88"
	private let reachability = Reachability()!
	static let shared = NetworkConnectionManager()
	
	
	private override init() {
		super.init()
	}
	
	func isAvailable(hostName: String) -> Reachability? {
		guard let reachability = Reachability(hostname: hostName) else { return nil }
		return reachability
	}
	
	func checkingConnection(completion: @escaping (_ status: Status<Reachability.Connection?>) -> Void) {
		// check if host name is available
		guard let _ = isAvailable(hostName: hostName) else {
			completion(.unavailable)
			return
		}
		
		// detect reachability follow connection
		reachability.whenReachable = { reachability in
			DispatchQueue.main.async {
				switch reachability.connection {
				case .wifi:
					completion(.available(.wifi))
				case .cellular:
					completion(.available(.cellular))
				case .none:
					completion(.unavailable)
				}
			}
			
		}
		
		reachability.whenUnreachable = { reachability in
			DispatchQueue.main.async {
				completion(.unavailable)
			}
		}
		startObservingNetwork(of: reachability)
	}
	
	private func startObservingNetwork(of reachability: Reachability) {
		do {
			try reachability.startNotifier()
		} catch {
			print("Unable to start notifier")
		}
	}
	
	private func stopObservingNetwork(of reachability: Reachability) {
		reachability.stopNotifier()
	}


}
