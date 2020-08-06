//
//  UICell+Extension.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

// MARK: UITableViewCell
protocol TableViewCellIdentifiable {
	static var identifier: String { get }
}

extension TableViewCellIdentifiable where Self: UITableViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UITableViewCell: TableViewCellIdentifiable {}

// MARK: UICollectionViewCell
protocol CollectionViewCellIdentifiable {
	static var identifier: String { get }
}

extension CollectionViewCellIdentifiable where Self: UICollectionViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UICollectionViewCell: CollectionViewCellIdentifiable {
}
