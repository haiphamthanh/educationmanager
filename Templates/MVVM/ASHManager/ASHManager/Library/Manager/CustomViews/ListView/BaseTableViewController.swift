//
//  BaseTableViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/12/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit
protocol BaseTableViewProtocol {
	associatedtype HeaderView: UIView, CellBehaviors
	func tableviewV(_ tableView: UITableView, viewForHeaderInSection section: Int) -> HeaderView?
}

class BaseTableViewHeader: UIView {
	private var data: T?
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setupSubViews()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubViews()
	}
	
	func setupSubViews() {
	}
	
	func reload(data: T?) {
		//
	}
}

extension BaseTableViewHeader: CellBehaviors {
	typealias T = Any
	
	func pushToCell(data: T) {
		self.data = data
		reload(data: data)
	}
}

class BaseTableViewController: ListViewController, BaseTableViewProtocol {
	typealias HeaderView = BaseTableViewHeader
	
	let SEPERATOR_COLOR = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
	
	// MARK: - ================================= Properties =================================
	private var viewModel: BaseViewModelProtocol? {
		return viewModelWraper(type: BaseViewModelProtocol.self)
	}
	
	private let tableView: UITableView = {
		let tableView = UITableView.init(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.alwaysBounceVertical = true
		return tableView
	}()
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addListView(tableView, to: view)
		configTableView(tableView)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		if tableView.contentInset != .zero { tableView.contentInset = .zero }
	}
	
	override func reloadData() {
		tableView.reloadData()
	}
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	override func cellIdentifies() -> [AnyClass] {
		return []
	}
	
	func tableviewV(_ tableviewV: UITableView, cellAt indexPath: IndexPath, usefor item: Any?) -> BaseTableViewCell {
		fatalError("Need implement in subclass")
	}
	
	func configTableView(_ tableView: UITableView) {
		tableView.separatorColor = SEPERATOR_COLOR
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		
		let allClassNibs = cellIdentifies()
		for nib in allClassNibs {
			tableView.registerCellNib(nib)
		}
	}
	
	// MARK: ============ HEADER & FOOTER ============
	func tableviewV(_ tableView: UITableView, viewForHeaderInSection section: Int) -> HeaderView? {
		return BaseTableViewHeader()
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
	}
	
	func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
	}
	
	// MARK: - ================================= Final =================================
	final func reloadSections(_ sections: IndexSet) {
		tableView.reloadSections(sections, with: .fade)
	}
	
	final override func stopRefresh() {
		tableView.es.stopPullToRefresh()
	}
	
	final override func stopLoadMore() {
		tableView.es.stopLoadingMore()
	}
	
	final override func noticeNoMoreData() {
		tableView.es.noticeNoMoreData()
	}
	
	// MARK: ============ Scroll table ============
	final func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
		tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
	}
	
	final func scrollToLast(animated: Bool) {
		tableView.scrollToLast(animated: animated)
	}
	
	func tableViewDidScroll(_ tableView: UITableView) {
	}
}

// MARK: - ================================= Final =================================
extension BaseTableViewController {
	func updateTableView(updateBlock: ()) {
		let currentOffset = self.tableView.contentOffset
		UIView.setAnimationsEnabled(false)
		tableView.beginUpdates()
		
		updateBlock
		
		tableView.endUpdates()
		UIView.setAnimationsEnabled(true)
		tableView.setContentOffset(currentOffset, animated: false)
	}
}

// MARK: - ================================= UITableViewDataSource =================================
extension BaseTableViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfItems(in: section)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		let sectionNumber = numberOfSections()
		tableView.isEmpty(sectionNumber == 0, show: emptyListMessage())
		
		return sectionNumber
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let itemAtIndexPath = item(at: indexPath)
		let cell = tableviewV(tableView, cellAt: indexPath, usefor: itemAtIndexPath)
		cell.pushToCell(data: itemAtIndexPath)
		return cell
	}
}

// MARK: - ================================= UITableViewDelegate =================================
extension BaseTableViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tapRow(at: indexPath)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return cellHeight(at: indexPath)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if tableView == scrollView {
			tableViewDidScroll(tableView)
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return headerTitle(in: section)
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return footerTitle(in: section)
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return headerHeight(section: section)
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return footerHeight(section: section)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let itemAtSection = item(at: section)
		let view = tableviewV(tableView, viewForHeaderInSection: section)
		view?.pushToCell(data: itemAtSection)
		
		return view
	}
}
