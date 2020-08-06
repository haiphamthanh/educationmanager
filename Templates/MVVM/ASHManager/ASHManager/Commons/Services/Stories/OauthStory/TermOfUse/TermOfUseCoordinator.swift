//
//  TermOfUseCoordinator.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class TermOfUseCoordinator: BaseCoordinator<Void> {
	override func doAction(viewModel: BaseViewModelProtocol?) -> Observable<Void> {
		guard let viewModel = viewModel as? TermOfUseViewModelProtocol else {
			return Observable.never()
		}
		
		// Done
		let understand = viewModel.understand.map({ _ in })
		
		// Merge action
		return understand
			.take(1)
			.do(onNext: { [weak self] _ in
				self?.backToPreviousIfNeeded()
			})
	}
}

// MARK: - ########################## Final ##########################
extension TermOfUseCoordinator: TermOfUseCoordinatorProtocol {
}
