//
//  RecordView.swift
//  SpeechRecognition
//
//  Created by TienHK on 5/15/18.
//  Copyright © 2018 TienHK. All rights reserved.
//

import UIKit

protocol RecordDelegate {
	func stopRecord()
}

class RecordView: UIView {
	
	struct Const {
		static let TITLE_HEIGHT: CGFloat = 30.0
		static let BUTTON_WIDTH: CGFloat = 80.0
		static let BUTTON_HEIGH: CGFloat = 40.0
		static let LINE_WIDTH_WAVE: CGFloat = 4.0
		static let AMPLITUDE_SOUND: CGFloat = -6.0
	}
	
	var actionDelegate: RecordDelegate?
	private var titleLabel: UILabel!
	var soundWaveView: PipeWaveView!
	private var doneButton: UIButton!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initComponent()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func initComponent() {
		titleLabel = UILabel()
		titleLabel.text = LocalizedString.titleRecognition()
		titleLabel.textAlignment = .center
		titleLabel.textColor = UIColor.white
		addSubview(titleLabel)
		
		soundWaveView = PipeWaveView()
		soundWaveView.backgroundColor = UIColor.clear
		soundWaveView.color = UIColor.white
		soundWaveView.amplitude = Const.AMPLITUDE_SOUND
		soundWaveView.lineWidth = Const.LINE_WIDTH_WAVE
		addSubview(soundWaveView)
		
		doneButton = UIButton()
		doneButton.setTitle(LocalizedString.titleDoneButton(), for: .normal)
		doneButton.setTitleColor(UIColor.white, for: .normal)
		doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
		addSubview(doneButton)
		
	}
	
	@objc func done() {
		actionDelegate?.stopRecord()
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		addGradient()
		titleLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: Const.TITLE_HEIGHT)
		soundWaveView.frame = CGRect(x: 0, y: Const.TITLE_HEIGHT, width: frame.size.width, height: frame.size.height - (Const.TITLE_HEIGHT + Const.BUTTON_HEIGH))
		doneButton.frame = CGRect(x: frame.size.width/2 - Const.BUTTON_WIDTH/2, y: soundWaveView.frame.size.height + Const.TITLE_HEIGHT, width: Const.BUTTON_WIDTH, height: Const.BUTTON_HEIGH)
	}
	
	
}
