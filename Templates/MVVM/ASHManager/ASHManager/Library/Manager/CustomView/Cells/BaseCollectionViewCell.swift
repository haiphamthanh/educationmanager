//
//  BaseCollectionViewCell.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/4/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
	// MARK: - ================================= Properties =================================
	private var data: T?
	private(set) var disposeBag = DisposeBag()
	override func prepareForReuse() {
		disposeBag = DisposeBag()
	}
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	/// Need to overried in subclass
	func setupSubViews() {
		backgroundColor = backgroundColor()
	}
	
	func reload(data: T) {
		fatalError("Implement in subclass")
	}
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	func backgroundColor() -> UIColor {
		return UIColor("F1F8E9")
	}
	
	// MARK: - ================================= Final =================================
	final override func awakeFromNib() {
		super.awakeFromNib()
		
		setupSubViews()
	}
}

// MARK: - ================================= Final =================================
extension BaseCollectionViewCell: CellBehaviors {
	typealias T = Any
	
	func pushToCell(data: T) {
		self.data = data
		reload(data: data)
	}
}

// MARK: - ================================= Private =================================
private extension BaseTableViewCell {
}
