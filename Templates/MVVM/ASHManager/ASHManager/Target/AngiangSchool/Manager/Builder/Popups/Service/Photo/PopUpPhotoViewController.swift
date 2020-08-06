//
//  PhotoPopupViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import PopupDialog
import Photos
import RxSwift

class PopUpPhotoViewController: BasePopUpViewController<PopUpPhotoInput, PopUpPhotoOutput>, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	private var imagePickerVC: UIImagePickerController {
		let imagePickerVC = UIImagePickerController()
		imagePickerVC.delegate = self
		
		return imagePickerVC
	}
	
	private var location: CLLocation?
	private var image: Data? {
		didSet {
			ok()
		}
	}
	
	/// Output data
	///
	override func output() -> PopUpPhotoOutput? {
		return PopUpPhotoOutput(location: location, image: image)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			self.image = image.jpegData(compressionQuality: 1.0)
		}
		
		picker.dismiss(animated: true, completion: nil)
	}
}

extension PopUpPhotoViewController: PopUpPhotoBehaviors {
	func showPopup(_ type: PopUpPhoto) -> Observable<PopUpPhotoOutput> {
		switch type {
		case .camera:
			showCamera()
		case .gallery:
			showGallery()
		case .selection:
			break
		}
		
		return response
			.take(1)
	}
}

private extension PopUpPhotoViewController {
	func showGallery() {
		let alert = UIAlertController(style: .actionSheet)
		let alertCallback = { (asset: PHAsset?) in
			guard let asset = asset else {
				return
			}
			
			let size = self.sizeFor(asset: asset)
			let _ = Assets.resolve(assets: [asset], size: size) { fetchedImages in
				guard let image = fetchedImages.first else {
					return
				}
				
				self.location = asset.location
				self.image = image.jpegData(compressionQuality: 1.0)
			}
		}
		
		alert.addPhotoLibraryPicker(
			flow: .horizontal,
			paging: true,
			selection: .single(action: alertCallback))
		
		alert.addAction(title: "Cancel", style: .cancel)
		alert.show()
	}
	
	func showCamera(alowEditing: Bool = true) {
		if imagePickerVC.isBeingPresented {
			return
		}
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			imagePickerVC.sourceType = .camera;
			imagePickerVC.cameraDevice = .front
			imagePickerVC.allowsEditing = alowEditing
			if let topVC = UIApplication.topViewController() {
				topVC.present(imagePickerVC, animated: true, completion: nil)
			}
		}
	}
	
	func sizeFor(asset: PHAsset) -> CGSize {
		let height: CGFloat = TelegramPickerViewController.UI.maxHeight
		let width: CGFloat = CGFloat(Double(height) * Double(asset.pixelWidth) / Double(asset.pixelHeight))
		return CGSize(width: width, height: height)
	}
}
