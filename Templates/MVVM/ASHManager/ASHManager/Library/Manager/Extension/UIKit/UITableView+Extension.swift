//
//  TableViewExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
	
	func registerCellClass(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		self.register(cellClass, forCellReuseIdentifier: identifier)
	}
	
	func registerCellNib(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		let nib = UINib(nibName: identifier, bundle: nil)
		self.register(nib, forCellReuseIdentifier: identifier)
	}
	
	func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
		let identifier = String.className(viewClass)
		self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
	}
	
	func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
		let identifier = String.className(viewClass)
		let nib = UINib(nibName: identifier, bundle: nil)
		self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
	}
	
	//	func reusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
	//		guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath as IndexPath) as? T else {
	//			fatalError("Couldn't instantiate view controller with identifier \(T.identifier) ")
	//		}
	//
	//		return cell
	//	}
	
	func reusableCell<T>(_ type: T.Type, with identifier: String) -> T {
		return dequeueReusableCell(withIdentifier: identifier) as! T
	}
	
	func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
			else { fatalError("Could not deque cell with type \(T.self)") }
		return cell
	}
	
	func scrollToLast(animated : Bool) {
		let lastSectionIndex = self.numberOfSections - 1 // last section
		let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
		if lastRowIndex >= 0 {
			scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
		}		
	}
}

//MARK: - utils
extension UITableView {
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
