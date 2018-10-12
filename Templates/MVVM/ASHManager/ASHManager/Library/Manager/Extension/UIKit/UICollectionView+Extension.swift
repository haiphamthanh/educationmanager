//
//  UICollectionView+Extension.swift
//  ASHManager
//
//  Created by NamPC on 1/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit.UICollectionView

//MARK: - register cell
extension UICollectionView {
	func registerCellClass(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		self.register(cellClass, forCellWithReuseIdentifier: identifier)
	}
	
	func registerCellNib(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		let nib = UINib(nibName: identifier, bundle: nil)
		self.register(nib, forCellWithReuseIdentifier: identifier)
	}
	
	func reusableCell<T>(_ type: T.Type, with identifier: String, for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
	}
	
	func scrollToLast(animated : Bool) {
		let lastSection = numberOfSections - 1
		guard lastSection >= 0 else {
			return
		}
		
		let lastItem = numberOfItems(inSection: lastSection) - 1
		guard lastItem >= 0 else {
			return
		}
		
		let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
		scrollToItem(at: lastItemIndexPath, at: .bottom, animated: animated)
	}
}

//MARK: - utils
extension UICollectionView {
	func isEmpty(_ isEmpty: Bool, show mssg: String) {
		if isEmpty {
			emptyList(with: mssg)
			return
		}
		
		restore()
	}
	
	private func emptyList(with message: String) {
		let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
		messageLabel.text = message
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = .center;
		messageLabel.textColor = UIColor.darkGray
		messageLabel.font = UIFont.boldSystemFont(ofSize: 22)
		messageLabel.sizeToFit()
		
		backgroundView = messageLabel;
	}
	
	private func restore() {
		backgroundView = nil
	}
}
