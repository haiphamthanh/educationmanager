//
//  BasicInforWearableSelectionVC.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/28/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import RxSwift

class BasicInforWearableSelectionVC: BaseTableViewController {
	// MARK: - ================================= Properties =================================
	private let sources = [[(image: "Nike", name: "Nike+ FuelBand SE"),
							(image: "Acer", name: "Acer Liquid Leap+"),
							(image: "Xaomi", name: "Xiaomi Mi Band 1S"),
							(image: "Others", name: "LocalizedString.otherWearableButtonTitle()"),
							(image: "AppIcon", name: LocalizedString.otherWearableButtonTitle())]]
	
	// MARK: - ================================= Init =================================
	override func subcribeSetup() {
		super.subcribeSetup()
		
		tap.subscribe(onNext: { [weak self] item in
			self?.navigationController?.popViewController(animated: false)
		}).disposed(by: disposeBag)
	}
	
	// MARK: - ================================= Config views =================================
	override var canLoadMore: Bool {
		return false
	}
	
	override var paddingTop: CGFloat {
		return 90
	}
	
	override var isGradientBg: Bool {
		return true
	}
	
	override func setupViews() {
		super.setupViews()
		
		navigationItem.title = LocalizedString.otherWearableButtonTitle()
	}
	
	override class func storyNameProvider() -> String {
		return AppStoryboard.registrationDefines
	}
	
	
	// MARK: - ================================= DATA SOURCE =================================
	/// Use for customization
	/// Optional to overried in subclass
	override func configTableView(_ tableView: UITableView) {
		super.configTableView(tableView)
		
		tableView.separatorColor = UIColor.white
		tableView.separatorStyle = .singleLine
		tableView.contentInset.top = 44
	}
	
	override func cellIdentifies() -> [AnyClass] {
		var cells = super.cellIdentifies()
		cells.append(WearableCell.self)
		
		return cells
	}
	
	override func tableviewV(_ tableviewV: UITableView, cellAt indexPath: IndexPath, usefor item: Any?) -> BaseTableViewCell {
		return tableviewV.reusableCell(WearableCell.self, with: WearableCell.identifier)
	}
	
	override func item(from data: Any?, at indexPath: IndexPath) -> Any {
		return sources[indexPath.section][indexPath.row]
	}
	
	override func numberOfSections(from data: Any?) -> Int {
		return sources.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sources[section].count
	}
	
	override func cellHeight(at indexPath: IndexPath) -> CGFloat {
		return 96
	}
	
	override func footerTitle(from data: Any?, in section: Int) -> String? {
		return LocalizedString.noteTitle()
	}
	
	override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
		let border = CALayer()
		border.backgroundColor = UIColor.white.cgColor
		border.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 0.5)
		
		let footer = view as! UITableViewHeaderFooterView
		footer.textLabel?.setupFont()
		footer.textLabel?.textColor = .white
		footer.textLabel?.textAlignment = .center
		view.tintColor = .clear
		view.layer.addSublayer(border)
	}
}
