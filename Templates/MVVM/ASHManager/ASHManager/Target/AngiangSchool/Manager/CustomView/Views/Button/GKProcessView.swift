//
//  GKProcessView.swift
//  ASHManager
//
//  Created by TienNT12 on 2/6/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RxSwift

protocol GKProgressProtocol {
	func setProgress(_ progress: CGFloat)
}

class GKDownloadProcessView: GKProcessView, GKProgressProtocol {
	
	override var imageName: String {
		return "greencheck"
	}
	
	override var progressColor: String {
		return "#6ACA4D"
	}
	
	func setProgress(_ progress: CGFloat) {
		if progress >= 1.0 {
			if checkImageView.isHidden {
				checkImageView.isHidden = false
				checkImageView.layer.add(GKAnimationManager.transformAnimation(reverse: false), forKey: GKAnimationManagerKey.transform.rawValue)
				progressView.lineCap = .butt
				progressView.setProgress(progress: 1, animated: false)
			}
		} else {
			checkImageView.isHidden = true
			progressView.setProgress(progress: progress, animated: true)
		}
	}
}

enum GKCountdownButtonState: String {
	case begin = "Start"
	case doing = "Doing"
	case end = "Go!"
	
	func des() -> String {
		switch self {
		case .begin:
			return LocalizedString.localizedString(input: "Challenge_Start")
		case .end:
			return LocalizedString.localizedString(input: "Challenge_Go")
		default:
			return LocalizedString.localizedString(input: "Challenge_Start")
		}
	}
}

class GKCountdownButton: CircleButton {
	
	var timer: Timer?
	var time: Int = 0
	let labelArray = ["3", "2", "1"]
	var progressState: Observable<GKCountdownButtonState> {
		return pProgressState
	}
	private var pProgressState: PublishSubject<GKCountdownButtonState> = PublishSubject<GKCountdownButtonState>()
	
	private var currentState: GKCountdownButtonState = .begin {
		didSet {
			pProgressState.onNext(currentState)
			if currentState != .doing {
				setTitle(currentState.des(), for: .normal)
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		backgroundColor = UIColor.orange
		titleLabel?.font = AppFont.openSans_Regular.size(FontSize(rawValue: 36)!)
		setTitleColor(.white, for: .normal)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		currentState = .begin
	}
	
	func start() {
		currentState = .doing
		time = 0
		if timer == nil {
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleProcess), userInfo: nil, repeats: true)
		}
	}
	
	func reset() {
		currentState = .begin
		timer?.invalidate()
		timer = nil
		time = 0
	}
	
	func stop() {
		currentState = .end
		reset()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		
		if currentState == .doing {
			return
		}
		
		start()
	}
	
	@objc func handleProcess() {
		if time >= 0 && time < labelArray.count {
			setTitle(labelArray[time], for: .normal)
		}
		if time == labelArray.count {
			timer?.invalidate()
			timer = nil
			time = 0
			
			currentState = .end
		}
		
		time += 1
		layer.add(GKAnimationManager.transformAnimation(reverse: false), forKey: GKAnimationManagerKey.transform.rawValue)
	}
	
	override func fontProvider() -> UIFont {
		return GKFont.valueBold(with: .size30)
	}
}

class GKProcessView: UIView {
	
	var progressView: GKCircleProgress!
	var checkImageView: UIImageView!
	var imageName: String { return "" }
	var progressColor: String { return "" }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		progressView = GKCircleProgress(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		progressView.backgroundShapeColor = UIColor.lightGray
		progressView.backgroundColor = UIColor.clear
		progressView.percentColor = UIColor.clear
		progressView.progressShapeColor = UIColor(progressColor)
		progressView.spaceDegree = 0
		progressView.lineWidth = 3
		progressView.lineCap = .round
		progressView.inset = -3
		progressView.orientation = .top
		progressView.titleLabel.text = ""
		addSubview(progressView)
		
		checkImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
		checkImageView.center = progressView.center
		checkImageView.image = UIImage(named: imageName)
		addSubview(checkImageView)
	}
}
