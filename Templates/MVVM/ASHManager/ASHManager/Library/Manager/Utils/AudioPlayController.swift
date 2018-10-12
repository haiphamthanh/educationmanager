//
//  AudioPlayController1.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/14/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation
import AVFoundation
import CocoaLumberjack

protocol AudioPlayControllerDelegate : class {
	func audioPlayFinish()
	func audioPlayError()
	func audioPlayProgress(max: TimeInterval, current: TimeInterval)
}

class AudioPlayController : NSObject, AVAudioPlayerDelegate {
	
	private var audioURL: URL?
	private var player: AVAudioPlayer?
	var playing = false
	weak var delegate: AudioPlayControllerDelegate?
	
	override init() {
	}
	
	var maxTime: TimeInterval {
		return player!.duration
	}
	var currentTime: TimeInterval {
		return player!.currentTime
	}
	
	@objc func progress() {
		if playing {
			self.perform(#selector(AudioPlayController.progress), with: nil, afterDelay: 1)
			delegate?.audioPlayProgress(max: (player?.duration)!, current: (player?.currentTime)!)
		}
	}
	
	func play(url: URL, mixWithOtherAudio: Bool) {
		audioURL = url
		if let data = try? Data(contentsOf: url) {
			do {
				player = try AVAudioPlayer(data: data)
				if mixWithOtherAudio {
					try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
				} else {
					try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategorySoloAmbient)
				}
				player!.delegate = self
				player!.play()
			} catch {
				DDLogError("Failed to play")
				return
			}
			playing = true
			self.performSelector(onMainThread: #selector(AudioPlayController.progress), with: nil, waitUntilDone: false)
		}
	}
	
	func stop() {
		playing = false
		player?.stop()
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		playing = false
		delegate?.audioPlayFinish()
	}
	
	func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
		playing = false
		delegate?.audioPlayError()
	}
}
