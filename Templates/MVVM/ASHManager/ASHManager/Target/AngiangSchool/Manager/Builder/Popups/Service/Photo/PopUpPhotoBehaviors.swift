//
//  PopUpPhotoBehaviors.swift
//  ASHManager
//
//  Created by 7i3u7u on 11/18/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift
import CoreLocation

// MARK: - Type =================================
enum PopUpPhoto {
	case gallery
	case camera
	case selection
}

// MARK: - Behaviors =================================
protocol PopUpPhotoBehaviors {
	func showPopup(_ type: PopUpPhoto) -> Observable<PopUpPhotoOutput>
}

// MARK: - Input =================================
class PopUpPhotoInput {
	var value: In?
}

extension PopUpPhotoInput: PopUpInputProtocol {
	typealias In = Void
	
	func push(value: In? = nil) {
		self.value = value
	}
}

// MARK: - Output =================================
struct PopUpPhotoOutput {
	var location: CLLocation?
	var image: Data?
}

extension PopUpPhotoOutput: PopUpOutputProtocol {
	typealias Out = (location: CLLocation?, image: Data?)
	
	func asOutput() -> Out {
		return (location: location, image: image)
	}
}
