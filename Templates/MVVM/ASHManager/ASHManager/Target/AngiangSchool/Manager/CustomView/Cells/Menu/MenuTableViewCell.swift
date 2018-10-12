//
//  MenuTableViewCell.swift
//  ASHManager
//
//  Created by HaiPT15 on 2/9/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class MenuTableViewCell : BaseTableViewCell {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private weak var menuTitile: UILabel!
	
	// MARK: - ================================= Config views =================================
	override func setupSubViews() {
		super.setupSubViews()
		
		menuTitile?.textColor = UIColor("#ecf0f1")
	}
	
	override func backgroundColor() -> UIColor {
		return UIColor.clear
	}
	
	override func reload(data: T) {
		return reloadBright(data: data)
	}
}

// MARK: - ================================= Config cell =================================
private extension MenuTableViewCell {
//	typealias CellData = MenuItem
	typealias CellData = String
	
	func reloadBright(data: T) {
		let celldata = cellData(from: data)
		return configView(with: celldata)
	}
	
	func cellData(from data: T) -> CellData {
		guard let data = data as? CellData else {
			fatalError("Not support this data for cell")
		}
		
		return data
	}
	
	func configView(with content: CellData) {
//		menuTitile.text = content.name.uppercased()
		menuTitile.text = ""
	}
}
