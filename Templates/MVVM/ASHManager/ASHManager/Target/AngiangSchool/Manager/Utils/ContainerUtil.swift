//
//  ContainerUtil.swift
//  ASHManager
//
//  Created by HaiPD1 on 2/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit
import Foundation

class ContainerUtil {
	
	static func changeControllerView(viewController: UIViewController, containerView: UIView, indentifierFromViewController: String, indentifierToViewController: String) {
		let fromViewController = viewController.storyboard?.instantiateViewController(withIdentifier: indentifierFromViewController)
		let toViewController = viewController.storyboard?.instantiateViewController(withIdentifier: indentifierToViewController)
		
		if (fromViewController == nil || toViewController == nil || viewController.childViewControllers.last == toViewController) {
			return
		}
		
		fromViewController!.willMove(toParentViewController: nil)
		let newFrame = CGRect(origin: .zero, size: CGSize(width: containerView.frame.width, height: containerView.frame.height))
		toViewController!.view.frame = newFrame
		viewController.addChildViewController(toViewController!)
		viewController.view.addSubview((toViewController?.view)!)
		
		toViewController!.view.alpha = 0
		toViewController!.view.layoutIfNeeded()
		UIView.animate(withDuration: 0.5, animations: {
			toViewController!.view.alpha = 1
			fromViewController!.view.alpha = 0
		}, completion: { finished in
			fromViewController!.view.removeFromSuperview()
			fromViewController!.removeFromParentViewController()
			toViewController!.didMove(toParentViewController: viewController)
		})
	}
}
