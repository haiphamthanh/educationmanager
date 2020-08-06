//
//  FilePath.swift
//  ASHManager
//
//  Created by HaiPT15 on 12/13/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation

class FullPath {
	static func deleteFullPath(_ fullPath: String) {
		_ = try? FileManager.default.removeItem(atPath: fullPath)
	}
}

class DocumentDirectory: FullPath {
	static func dirPath() -> String {
		return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
	}
	
	static func getURL() -> URL {
		let fileManager = FileManager.default
		return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
	}
	
	class func documentsDirectory() -> URL {
		return getURL().appendingPathComponent("documents", isDirectory: true)
	}
	
	static func deleteWallpaperByName(_ wallpaperName: String) {
		let path = RelativePath.wallpaperWithFileName(wallpaperName).toDocumentDirectoryFullPath()
		let fileManager = FileManager.default
		if fileManager.fileExists(atPath: path) {
			try! fileManager.removeItem(atPath: path)
		}
	}
	
	static func createWallpapersDirectory() {
		let components = [dirPath(), "Wallpapers"]
		let path = NSString.path(withComponents: components)
		let fileManager = FileManager.default
		
		if !fileManager.fileExists(atPath: path) {
			try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
		}
	}
	
	struct RelativePath {
		static func wallpaperWithFileName(_ filename: String) -> String {
			let components = ["Wallpapers", filename]
			let path = NSString.path(withComponents: components)
			return path
		}
	}
}

class CacheDirectory: FullPath {
	static func dirPath() -> String {
		return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
	}
}

extension String {
	func toDocumentDirectoryFullPath() -> String {
		let path = NSString.path(withComponents: [DocumentDirectory.dirPath(), self])
		(path as NSString).deletingLastPathComponent.mkdirs()
		return path
	}
	
	func toCacheDirectoryFullPath() -> String {
		let path = NSString.path(withComponents: [CacheDirectory.dirPath(), self])
		(path as NSString).deletingLastPathComponent.mkdirs()
		return path
	}
	
	func mkdirs() {
		try! FileManager.default.createDirectory(atPath: self, withIntermediateDirectories: true, attributes: nil)
	}
	
	func cleanDirectory() {
		let mngr = FileManager.default
		if let files = try? mngr.contentsOfDirectory(atPath: self) {
			for filename in files {
				_ = try? mngr.removeItem(atPath: NSString.path(withComponents: [self, filename]))
			}
		}
	}
}
