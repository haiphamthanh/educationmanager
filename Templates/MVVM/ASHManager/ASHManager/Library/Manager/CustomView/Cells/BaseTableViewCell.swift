//
//  BaseTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import RxSwift

protocol CellBehaviors {
	associatedtype T
	func pushToCell(data: T)
}

class BaseTableViewCell: UITableViewCell {
	// MARK: - ================================= Properties =================================
	private(set) var data: T?
	private(set) var disposeBag = DisposeBag()
	override func prepareForReuse() {
		disposeBag = DisposeBag()
	}
	
	// MARK: - ================================= Init view =================================
	/// Use for customization
	/// Need to overried in subclass
	func setupSubViews() {
		textLabel?.font = textFont()
		textLabel?.textColor = textColor()
		backgroundColor = backgroundColor()
	}
	
	func reload(data: T) {
		fatalError("Implement in subclass")
	}
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	func textColor() -> UIColor {
		return UIColor("9E9E9E")
	}
	
	func textFont() -> UIFont {
		return UIFont.italicSystemFont(ofSize: 18)
	}
	
	func backgroundColor() -> UIColor {
		return UIColor("F1F8E9")
	}
	
	func highlightedAlpha() -> CGFloat {
		return 0.4
	}
	
	func unHighlightedAlpha() -> CGFloat {
		return 1.0
	}
	
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		alpha = highlighted ? highlightedAlpha() : unHighlightedAlpha()
	}
	
	// ignore the default handling
	override func setSelected(_ selected: Bool, animated: Bool) {
	}
	
	// MARK: - ================================= Final =================================
	final override func awakeFromNib() {
		super.awakeFromNib()
		
		setupSubViews()
	}
}

// MARK: - ================================= Final =================================
extension BaseTableViewCell: CellBehaviors {
	typealias T = Any
	
	func pushToCell(data: T) {
		self.data = data
		reload(data: data)
	}
}

// MARK: - ================================= Private =================================
private extension BaseTableViewCell {
}
