//
//  SpeechRecognitionController.swift
//  SpeechRecognition
//
//  Created by TienHK on 5/15/18.
//  Copyright © 2018 TienHK. All rights reserved.
//

import AVFoundation
import Speech
import CocoaLumberjack


enum SpeechRecognitionControllerError : Error {
	case notAuthorized
	case noSpeechRecognizer
	case speechRecognizerUnavailable
	case noInputNodes
	case alreadyRunning
	case notSupported
}

@objc protocol SpeechRecognitionControllerDelegate : NSObjectProtocol {
	
	@objc optional func speechRecognitionController(_ controller: SpeechRecognitionController, didFinishRecognition string: String)
	
	@objc optional func speechRecognitionController(controller: SpeechRecognitionController, didFailRecognition error: Error?)
	
	@objc optional func speechRecognitionController(_ controller: SpeechRecognitionController, didReceivePartialResult string: String)
	
	@objc optional func speechRecognitionControllerDidCancel(_ controller: SpeechRecognitionController)
	
	@objc optional func speechRecognitionControllerDidStartReadingAudio(_ controller: SpeechRecognitionController)
	
	@objc optional func speechRecognitionControllerDidStopReadingAudio(_ controller: SpeechRecognitionController)
}

class SpeechRecognitionController: NSObject {
	
	static let bufferSize = 2048
	static let bus = 0
	
	private var _speechRecognizer: AnyObject? = nil
	private var _recognitionRequest: AnyObject? = nil
	private var _recognitionTask: AnyObject? = nil
	
	@available(iOS 10.0, *)
	var speechRecognizer: SFSpeechRecognizer? {
		get {
			if _speechRecognizer == nil {
				_speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja"))
			}
			return _speechRecognizer as? SFSpeechRecognizer
		}
	}
	
	@available(iOS 10.0, *)
	var recognitionRequest: SFSpeechRecognitionRequest? {
		get {
			return _recognitionRequest as? SFSpeechRecognitionRequest
		}
		set {
			_recognitionRequest = newValue
		}
	}
	
	@available(iOS 10.0, *)
	var recognitionTask: SFSpeechRecognitionTask? {
		get {
			return _recognitionTask as? SFSpeechRecognitionTask
		}
		set {
			_recognitionTask = newValue
		}
	}
	
	var recognitionSoundFormatSettings: Dictionary<String, AnyObject> = [AVSampleRateKey : NSNumber(value: Float(44100.0)),
																		 AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
																		 AVNumberOfChannelsKey : NSNumber(value: 1),
																		 AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.min.rawValue))]
	
	let audioEngine = AVAudioEngine()
	var soundWave: Float = 0.0
	var timer: Timer?
	let audioPercentageUserInfoKey = "percentage"
	var inputNode: AVAudioInputNode? = nil
	var audioFile: AVAudioFile? = nil
	
	weak var delegate: SpeechRecognitionControllerDelegate?
	
	class func isAuthorized() -> Bool {
		guard #available(iOS 10.0, *) else {
			return false
		}
		return (SFSpeechRecognizer.authorizationStatus() == .authorized)
	}
	
	class func requestPermission(_ resultClosure: ((Bool) -> Void)?) {
		guard #available(iOS 10.0, *) else {
			if let closure = resultClosure {
				DispatchQueue.main.async {
					closure(false)
				}
			}
			return
		}
		SFSpeechRecognizer.requestAuthorization { (authStatus) in
			var authorized = false
			switch (authStatus) {
			case .authorized:
				authorized = true
				break
			case .denied:
				let alert = UIAlertController(title: "Speech Recognition Permissions", message: "In Iphone settings, tap Genki and turn on Speech Recognition", preferredStyle: .alert)
				let okAction = UIAlertAction(title: "Open Setting", style: .default, handler: { (action) in
					UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
				})
				let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
				alert.addAction(okAction)
				alert.addAction(cancelAction)
				UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
				break
			case .notDetermined:
				fallthrough
			case .restricted:
				break
			}
			if let closure = resultClosure {
				closure(authorized)
			}
		}
	}
	
	func startRecording(url: URL? = nil) throws {
		guard #available(iOS 10.0, *) else {
			DDLogError("Speech Recognizer API is not supported current iOS.")
			throw SpeechRecognitionControllerError.notSupported
		}
		if !SpeechRecognitionController.isAuthorized() {
			DDLogError("Speech Recognizer is not authorized by user.")
			throw SpeechRecognitionControllerError.notAuthorized
		}
		guard let recognizer = self.speechRecognizer else {
			DDLogError("Speech Recognizer object is null, it may be unsupported for current locale.")
			throw SpeechRecognitionControllerError.noSpeechRecognizer
		}
		
		let inputNode = audioEngine.inputNode
		guard inputNode.numberOfInputs > 0 else {
			DDLogError("AVAudioEngine has no inputNodes.")
			throw SpeechRecognitionControllerError.noInputNodes
		}
		self.inputNode = inputNode
		
		if let task = self.recognitionTask {
			task.cancel()
			self.recognitionTask = nil
		}
		
		let audioSession = AVAudioSession.sharedInstance()
		
		do {
			try audioSession.setCategory(AVAudioSessionCategoryRecord)
			try audioSession.setMode(AVAudioSessionModeMeasurement)
			try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
		} catch let error as NSError {
			DDLogError("Failed to call AVAudioSession functions. [error=\(error)]")
			DispatchQueue.main.async {
				self.delegate?.speechRecognitionController?(controller: self, didFailRecognition: error)
			}
			return
		}
		
		if let audioStoreUrl = url {
			do {
				let audioFile = try AVAudioFile(forWriting: audioStoreUrl, settings: self.recognitionSoundFormatSettings)
				self.audioFile = audioFile
			} catch let error as NSError {
				DDLogWarn("Failed to create an AVAudioFile object. [error=\(error)")
				self.audioFile = nil
			}
		}
		
		let request = SFSpeechAudioBufferRecognitionRequest()
		recognitionRequest = request as SFSpeechAudioBufferRecognitionRequest
		recognitionTask = recognizer.recognitionTask(with: request, delegate: self)
		recognizer.delegate = self
		let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
		inputNode.installTap(onBus: SpeechRecognitionController.bus,
							 bufferSize: AVAudioFrameCount(SpeechRecognitionController.bufferSize),
							 format: format) { [weak self] (buffer, when) in
								let dataptrptr = buffer.floatChannelData!
								let dataptr = dataptrptr.pointee
								let datum = dataptr[Int(buffer.frameLength) - 1]
								
								//store the float on the variable
								self?.soundWave = fabs((datum))
								guard let request = self?.recognitionRequest as? SFSpeechAudioBufferRecognitionRequest else {
									DDLogWarn("SFSpeechRequest is not audio buffer seech recognition request.")
									return
								}
								if let audioFile = self?.audioFile {
									do {
										try audioFile.write(from: buffer)
									} catch let error as NSError {
										DDLogWarn("Failed to write audio buffer to file. [error=\(error)")
									}
								}
								request.append(buffer)
		}
		
		audioEngine.prepare()
		
		do {
			try audioEngine.start()
		} catch let error as NSError {
			DDLogError("Failed to start audio engine. [error=\(error)]")
			DispatchQueue.main.async {
				self.delegate?.speechRecognitionController?(controller: self, didFailRecognition: error)
			}
			return
		}
		timer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(updateMeter), userInfo: nil, repeats: true)
		self.delegate?.speechRecognitionControllerDidStartReadingAudio?(self)
	}
	
	@objc private func updateMeter() {
		if audioEngine.isRunning {
			NotificationCenter.default.post(name: .audioRecorderManagerMeteringLevelDidUpdateNotification, object: self, userInfo: [audioPercentageUserInfoKey: soundWave])
		}
	}
	
	func stopRecording() throws {
		guard #available(iOS 10.0, *) else {
			DDLogError("Speech Recognizer API is not supported current iOS.")
			throw SpeechRecognitionControllerError.notSupported
		}
		guard audioEngine.isRunning else {
			DDLogWarn("AudioEngine is not running")
			throw SpeechRecognitionControllerError.alreadyRunning
		}
		if self.inputNode != nil {
			let audioSession = AVAudioSession.sharedInstance()
			do {
				try audioSession.setCategory(AVAudioSessionCategoryPlayback)
				try audioSession.setMode(AVAudioSessionModeDefault)
			} catch  {}
			self.inputNode?.removeTap(onBus: SpeechRecognitionController.bus)
			self.inputNode = nil
		}
		audioEngine.stop()
		if let request = self.recognitionRequest as? SFSpeechAudioBufferRecognitionRequest {
			request.endAudio()
		}
		self.audioFile = nil
	}
	
	func cancel() {
		guard #available(iOS 10.0, *) else {
			DDLogError("Speech Recognizer API is not supported current iOS.")
			return
		}
		if self.inputNode != nil {
			self.inputNode?.removeTap(onBus: SpeechRecognitionController.bus)
			self.inputNode = nil
		}
		audioEngine.stop()
		recognitionTask?.cancel()
		self.audioFile = nil
	}
	
	func startSpeechURLRecognize(url: URL) throws {
		guard #available(iOS 10.0, *) else {
			DDLogError("Speech Recognizer API is not supported current iOS.")
			throw SpeechRecognitionControllerError.notSupported
		}
		if !SpeechRecognitionController.isAuthorized() {
			DDLogError("Speech Recognizer is not authorized by user.")
			throw SpeechRecognitionControllerError.notAuthorized
		}
		guard let recognizer = self.speechRecognizer else {
			DDLogError("Speech Recognizer object is null, it may be unsupported for current locale.")
			throw SpeechRecognitionControllerError.noSpeechRecognizer
		}
		/*
		if !recognizer.isAvailable {
		DDLogError("Speech Recognizer is unavailable.")
		throw ACSpeechRecognitionControllerError.SpeechRecognizerUnavailable
		}
		*/
		if let task = self.recognitionTask {
			task.cancel()
			self.recognitionTask = nil
		}
		let request = SFSpeechURLRecognitionRequest(url: url)
		recognitionRequest = request as SFSpeechURLRecognitionRequest
		recognitionTask = recognizer.recognitionTask(with: request, delegate: self)
		recognizer.delegate = self
	}
}

@available(iOS 10.0, *)
extension SpeechRecognitionController : SFSpeechRecognizerDelegate {
	// Called when the availability of the given recognizer changes
	func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
		DDLogDebug("SpeechRecognizer Availability has changed. => Available: \(available)")
	}
}

@available(iOS 10.0, *)
extension SpeechRecognitionController : SFSpeechRecognitionTaskDelegate {
	func speechRecognitionDidDetectSpeech(_ task: SFSpeechRecognitionTask) {
		DDLogDebug("speechRecognitionDidDetectSpeech(_ task:)")
	}
	
	func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
		DDLogDebug("speechRecognitionTask(_ task:, didHypothesizeTranscription transcription: [transcription=\(transcription))")
		self.delegate?.speechRecognitionController?(self, didReceivePartialResult: transcription.formattedString)
	}
	
	func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
		DDLogDebug("speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition \(recognitionResult): SFSpeechRecognitionResult)")
		if recognitionResult.isFinal {
			DDLogError("Recognized Text=\(recognitionResult.bestTranscription.formattedString)")
			self.delegate?.speechRecognitionController?(self, didFinishRecognition: recognitionResult.bestTranscription.formattedString)
		}
	}
	
	func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
		DDLogDebug("speechRecognitionTaskFinishedReadingAudio")
		self.delegate?.speechRecognitionControllerDidStopReadingAudio?(self)
	}
	
	func speechRecognitionTaskWasCancelled(_ task: SFSpeechRecognitionTask) {
		DDLogDebug("speechRecognitionTaskWasCancelled")
		self.delegate?.speechRecognitionControllerDidCancel?(self)
	}
	
	func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
		DDLogDebug("speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully \(successfully): Bool)")
		if !successfully {
			DDLogError("Failed to processing Speech Recognition task.")
			if let error = task.error {
				DDLogError("[error=\(error)]")
			}
			self.delegate?.speechRecognitionController?(controller: self, didFailRecognition: task.error)
		}
		if self.inputNode != nil {
			self.inputNode?.removeTap(onBus: SpeechRecognitionController.bus)
			self.inputNode = nil
		}
		audioEngine.stop()
		self.audioFile = nil
	}
}

extension Notification.Name {
	static let audioRecorderManagerMeteringLevelDidUpdateNotification = Notification.Name("AudioRecorderManagerMeteringLevelDidUpdateNotification")
}

