//
//  GKLoadingViewController.swift
//  ASHManager
//
//  Created by TienNT12 on 6/7/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

enum LoadingView: Int {
	case network = 0
	case dashboard
}

class GKLoadingViewController: UIViewController {
	
	@IBOutlet weak var loadingStatus: UILabel!
	private var viewType = LoadingView.dashboard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		reloadView(with: viewType)
	}
	
	final func change(viewType: LoadingView) {
		self.viewType = viewType
	}
	
	private func reloadView(with viewType: LoadingView) {
		switch viewType {
		case .network:
			loadingStatus.text = LocalizedString.localizedString(input: "No_Network_Title")
		case .dashboard:
			loadingStatus.text = LocalizedString.localizedString(input: "Chart_Data_Loading")
		}
	}
}
