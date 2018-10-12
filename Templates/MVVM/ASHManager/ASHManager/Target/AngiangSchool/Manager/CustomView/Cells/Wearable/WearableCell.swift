//
//  WearableCell.swift
//  ASHManager
//
//  Created by NamPC on 4/16/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

class WearableCell: BaseTableViewCell {
	// MARK: - ================================= Outlet =================================
	@IBOutlet private var iconImage: UIImageView!
	@IBOutlet private var textName: UITextField!
	
	// MARK: - ================================= Config views =================================
	override func reload(data: T) {
		return reloadBright(data: data)
	}
}

// MARK: - ================================= Config cell =================================
private extension WearableCell {
	typealias CellData = (image: String, name: String)
	
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
	
	func configView(with data: CellData) {
		iconImage.image = UIImage(named: data.image)
		textName.text = data.name
	}
}
