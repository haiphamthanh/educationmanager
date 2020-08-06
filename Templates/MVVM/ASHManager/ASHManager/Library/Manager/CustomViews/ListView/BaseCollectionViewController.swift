//
//  BaseCollectionViewController.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/8/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ESPullToRefresh

class BaseCollectionViewController: ListViewController {
	// MARK: - ================================= Properties =================================
	private var viewModel: BaseViewModelProtocol {
		return viewModelWraper(type: BaseViewModelProtocol.self)
	}
	
	private let collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.alwaysBounceVertical = true
		return collectionView
	}()
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addListView(collectionView, to: view)
		configCollectionView(collectionView)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		if collectionView.contentInset != .zero {
			collectionView.contentInset = .zero
		}
	}
	
	override func reloadData() {
		collectionView.reloadData()
	}
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	override func cellIdentifies() -> [AnyClass] {
		return [BaseCollectionViewCell.self]
	}
	
	func cellWidth(at indexPath: IndexPath) -> CGFloat {
		return collectionView.frame.size.width - 8
	}
	
	func collectionV(_ collectionView: UICollectionView, cellAt indexPath: IndexPath, usefor item: Any?) -> BaseCollectionViewCell {
		return collectionView.reusableCell(BaseCollectionViewCell.self, with: BaseCollectionViewCell.identifier, for: indexPath)
	}
	
	func configCollectionView(_ collectionView: UICollectionView) {
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.scrollDirection = .vertical
		
		collectionView.superview?.backgroundColor = .clear
		collectionView.backgroundColor = .clear
		collectionView.delegate = self
		collectionView.dataSource = self
		
		let allClassNibs = cellIdentifies()
		for nib in allClassNibs {
			collectionView.registerCellNib(nib)
		}
	}
	
	// MARK: - ================================= Final =================================
	final override func stopRefresh() {
		collectionView.es.stopPullToRefresh()
	}
	
	final override func stopLoadMore() {
		collectionView.es.stopLoadingMore()
	}
	
	final override func noticeNoMoreData() {
		collectionView.es.noticeNoMoreData()
	}
	
	// MARK: ============ Scroll table ============
	final func scroll(to indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
		collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
	}
	
	final func scrollToLast(animated: Bool) {
	}
}

// MARK: - ================================= UICollectionViewDataSource =================================
extension BaseCollectionViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numberOfItems(in: section)
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		let sectionNumber = numberOfSections()
		collectionView.isEmpty(sectionNumber == 0, show: emptyListMessage())
		
		return sectionNumber
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let itemAtIndexPath = item(at: indexPath)
		let cell = collectionV(collectionView, cellAt: indexPath, usefor: itemAtIndexPath)
		cell.pushToCell(data: itemAtIndexPath)
		
		return cell
	}
}

// MARK: - ================================= UICollectionViewDelegate =================================
extension BaseCollectionViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		tapRow(at: indexPath)
	}
}

// MARK: - ================================= UICollectionViewDelegateFlowLayout =================================
extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: cellWidth(at: indexPath), height: cellHeight(at: indexPath))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
	}
}
