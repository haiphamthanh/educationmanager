//
//  ListViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import ESPullToRefresh

struct ListItem {
	var icon: String?
	var title: String?
	var detailInfor: Any?
	var viewType: Any?
	
	init(icon: String?, title: String?, detailInfor: Any? = nil, viewType: Any?) {
		self.icon = icon
		self.title = title
		self.detailInfor = detailInfor
		self.viewType = viewType
	}
}

struct ListSection {
	var name: String? = ""
	var items: [ListItem]
}

class ListViewController : ViewControllerAdapter {
	// MARK: - ================================= Properties =================================
	private var viewModel: ViewModelAdapterProtocol {
		return viewModelWraper(type: ViewModelAdapterProtocol.self)
	}
	
	private var data: Any?
	let normalHeaderHeight = CGFloat(42.0)
	var paddingTop: CGFloat {
		return 0
	}
	/// subcribe this property to handle cell tap
	private(set) var tap: Observable<Any?> = PublishSubject<Any?>()
	
	/// return true if you have plan to use loading more item
	var canLoadMore: Bool {
		return false
	}
	
	/// return true if you have plan to use refresh item
	var canPullToRefresh: Bool {
		return false
	}
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	/// Need to overried in subclass
	/// Use for reload table view or collection view
	func reloadData() {
		fatalError("Need implement in subclass")
	}
	
	func refreshData() {
		let completed = strongify(self, closure: { (instance, _: Void) in
			instance.stopRefresh()
		})
		
		reloadObser()
			.subscribe(onCompleted: completed)
			.disposed(by: disposeBag)
	}
	
	/// Should final in 1-subclass
	func stopRefresh() {
		fatalError("Need implementation as final in subclass")
	}
	
	/// Only inherit if needed
	/// Customize container table view
	///
	/// - Parameters:
	///   - listView: table view or collection view
	///   - view: container for list view
	func addListView(_ listView: UIScrollView, to view: UIView) {
		view.addSubview(listView)
		let viewsDict = [
			"listView": listView
		]
		let vflDict = [
			"H:|-0-[listView]-0-|",
			"V:|-\(paddingTop)-[listView]-0-|"
		]
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vflDict[0] as String,
														   options: [], metrics: nil, views: viewsDict))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vflDict[1] as String,
														   options: [], metrics: nil, views: viewsDict))
		
		if canPullToRefresh {
			listView.es.addPullToRefresh { [weak self] in
				self?.refreshData()
			}
		}
		
		if canLoadMore {
			listView.es.addInfiniteScrolling { [weak self] in
				self?.loadmoreData()
			}
		}
	}
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	func cellIdentifies() -> [AnyClass] {
		return []
	}
	
	func cellHeight(at indexPath: IndexPath) -> CGFloat {
		return 48
	}
	
	func numberOfSections(from data: Any?) -> Int {
		return 0
	}
	
	func numberOfItems(from data: Any?, in section: Int) -> Int {
		return 0
	}
	
	func headerHeight(section: Int) -> CGFloat {
		return 0.0
	}
	
	func footerHeight(section: Int) -> CGFloat {
		return 0.0
	}
	
	func headerTitle(from data: Any?, in section: Int) -> String? {
		return ""
	}
	
	func footerTitle(from data: Any?, in section: Int) -> String? {
		return ""
	}
	
	func item(from data: Any?, at indexPath: IndexPath) -> Any {
		fatalError("Need implementation as final in subclass")
	}
	
	func item(from data: Any?, at section: Int) -> Any {
		fatalError("Need implementation as final in subclass")
	}
	
	func emptyListMessage() -> String {
		return LocalizedString.nodata()
	}
	
	// MARK: - ================================= Optional =================================
	/// If canLoadMore = true
	func loadmoreData() {
		if !viewModel.canLoadMore() {
			noticeNoMoreData()
			return
		}
		
		let completed = strongify(self, closure: { (instance, _: Void) in
			instance.stopLoadMore()
		})
		
		loadmoreObs()
			.subscribe(onCompleted: completed)
			.disposed(by: disposeBag)
	}
	
	/// If canLoadMore = true
	/// Should final in 1-subclass
	func stopLoadMore() {
		fatalError("Need implementation as final in subclass")
	}
	
	func noticeNoMoreData() {
		fatalError("Need implementation as final in subclass")
	}
}

// MARK: - ================================= Final should only use in first-subclass =================================
extension ListViewController {
	func push(data: Any?) {
		self.data = data
		reloadData()
	}
	
	func numberOfSections() -> Int {
		return numberOfSections(from: data)
	}
	
	func numberOfItems(in section: Int) -> Int {
		return numberOfItems(from: data, in: section)
	}
	
	func headerTitle(in section: Int) -> String? {
		return headerTitle(from: data, in: section)
	}
	
	func footerTitle(in section: Int) -> String? {
		return headerTitle(from: data, in: section)
	}
	
	func item(at indexPath: IndexPath) -> Any {
		return item(from: data, at: indexPath)
	}
	
	func item(at section: Int) -> Any {
		return item(from: data, at: section)
	}
	
	func tapRow(at indexPath: IndexPath) {
		let value = item(at: indexPath)
		if let tap = tap as? PublishSubject {
			tap.onNext(value)
		}
	}
}
