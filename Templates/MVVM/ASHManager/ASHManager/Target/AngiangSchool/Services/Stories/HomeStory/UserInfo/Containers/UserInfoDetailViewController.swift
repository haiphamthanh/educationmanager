//
//  UserInfoDetailViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 12/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

// MARK: - ViewData =================================
struct UserInfoDetailViewInput {
	
}

// MARK: - Defination =================================
class UserInfoDetailViewController: BaseTableViewController {
	private let pHeightChanged = BehaviorSubject<Int>(value: 0)
	
	override func configTableView(_ tableView: UITableView) {
		super.configTableView(tableView)
		
		tableView.separatorStyle = .singleLine
	}
	
	override func cellIdentifies() -> [AnyClass] {
		return [UserInfoTableViewCell.self]
	}
	
	override func numberOfSections(from data: Any?) -> Int {
		return 1
	}
	
	override func numberOfItems(from data: Any?, in section: Int) -> Int {
		return 10
	}
	
	override func item(from data: Any?, at indexPath: IndexPath) -> Any {
		return ""
	}
	
	override func tableviewV(_ tableviewV: UITableView, cellAt indexPath: IndexPath, usefor item: Any?) -> BaseTableViewCell {
		return tableviewV.reusableCell(UserInfoTableViewCell.self, with: UserInfoTableViewCell.identifier)
	}
}

// MARK: - Input =================================
extension UserInfoDetailViewController {
	typealias Input = UserInfoDetailViewInput
	
	var heightChanged: Observable<Int> {
		return pHeightChanged
	}
	
	func push(input: Input) {
		reloadView(with: input)
	}
}

// MARK: - Private =================================
private extension UserInfoDetailViewController {
	func reloadView(with input: Input) {
		updateTableHeight()
	}
	
	func updateTableHeight() {
		let height = tableHeight()
		pHeightChanged.onNext(height)
	}
	
	func tableHeight() -> Int {
		let indexPath =  IndexPath(row: 0, section: 0)
		let height = numberOfItems(in: 0) * Int(cellHeight(at: indexPath))
		
		return height
	}
}
