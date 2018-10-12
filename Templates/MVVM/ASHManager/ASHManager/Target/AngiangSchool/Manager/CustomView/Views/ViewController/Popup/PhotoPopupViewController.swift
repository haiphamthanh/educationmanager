//
//  PhotoPopupViewController.swift
//  ASHManager
//
//  Created by 7i3u7u on 9/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import PopupDialog

enum PhotoPopup {
	case selection
	case photo
	case camera
}

class PhotoPopUpInput: AbstractPopUpOutput {
	let image: UIImage
	required init(image: UIImage) {
		self.image = image
	}
}

// MARK: - ================================= camera =================================
class PhotoPopupViewController<I: AbstractPopUpInput, O: PhotoPopUpInput>: BasePopUpViewController<I, O>, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	private var imagePickerVC: UIImagePickerController {
		let imagePickerVC = UIImagePickerController()
		imagePickerVC.delegate = self
		
		return imagePickerVC
	}
	
	private var popUpStype = PhotoPopup.selection
	private var image: UIImage? {
		didSet {
			ok()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		switch popUpStype {
		case .selection:
			showSelectPhoto()
		case .camera:
			presentCamera()
		case .photo:
			showGallery()
		}
	}
	
	private func showSelectPhoto() {
		//		let titleDialog = LocalizedString.titlePopup()
		//		imagePickerVC = UIImagePickerController()
		//		let camera = DialogButton.init().normalButton(title: LocalizedString.titleCamera(),
		//													  image: UIImage.init(named: "camera")!,
		//													  font: GKFont.value(with: .size15),
		//													  color: UIColor.black) {
		//														self.showCamera()
		//		}
		//
		//		let gallery = DialogButton.init().normalButton(title: LocalizedString.titlePhoto(),
		//													   image: UIImage.init(named: "picture")!,
		//													   font: GKFont.value(with: .size15),
		//													   color: UIColor.black) {
		//														self.showGallery()
		//		}
		//
		//		let popup = PopupDialog(title: titleDialog,
		//								message: nil,
		//								buttonAlignment: .vertical,
		//								transitionStyle: .zoomIn,
		//								gestureDismissal: true,
		//								hideStatusBar: true)
		//		popup.addButtons([camera, gallery])
		//
		//		navigationController?.present(popup, animated: true, completion: nil)
	}
	
	private func presentCamera() {
		showCamera(alowEditing: false)
	}
	
	private func showGallery() {
		if imagePickerVC.isBeingPresented {
			return
		}
		
		imagePickerVC.allowsEditing = true
		imagePickerVC.sourceType = .photoLibrary
		if let topVC = UIApplication.topViewController() {
			topVC.present(imagePickerVC, animated: true, completion: nil)
		}
	}
	
	private func showCamera(alowEditing: Bool = true) {
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
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			self.image = image
		}
		
		picker.dismiss(animated: true, completion: nil)
	}
	
	override func actionData() -> O? {
		guard let image = image else {
			return nil
		}
		
		return O(image: image)
	}
}
