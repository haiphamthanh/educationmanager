//
//  DataPresentation.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import Foundation

protocol DataPresentation {
	associatedtype DataType
	func asData() -> DataType
}
