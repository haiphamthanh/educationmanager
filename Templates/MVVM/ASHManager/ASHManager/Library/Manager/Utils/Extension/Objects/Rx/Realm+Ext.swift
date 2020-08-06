//
//  Realm+Ext.swift
//  ASHManager
//
//  Created by 7i3u7u on 1/27/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import RealmSwift
import RxSwift

// MARK: - Action =================================
extension Reactive where Base: Realm {
	func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<R> where R.RealmType: Object  {
		return Observable.create { observer in
			do {
				try self.base.write {
					self.base.add(entity.asRealm(), update: update)
				}
				observer.onNext(entity)
				observer.onCompleted()
			} catch {
				observer.onError(error)
			}
			
			return Disposables.create()
		}
	}
	
	func delete<R: RealmRepresentable>(entity: R) -> Observable<R> where R.RealmType: Object {
		return Observable.create { observer in
			do {
				guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else {
					fatalError()
				}
				
				try self.base.write {
					self.base.delete(object)
				}
				
				observer.onNext(entity)
				observer.onCompleted()
			} catch {
				observer.onError(error)
			}
			
			return Disposables.create()
		}
	}
}

// MARK: - Objective =================================
extension Object {
	static func build<O: Object>(_ builder: (O) -> () ) -> O {
		let object = O()
		builder(object)
		return object
	}
	
	func splitCsv(string: String) -> [String] {
		return string.split(separator: ",").map{ String($0) }
	}
}

extension Results {
	func toArray () -> [Object] {
		var array = [Object]()
		for result in self {
			array.append(result as! Object)
		}
		
		return array
	}
}



// MARK: - Sorting =================================
extension SortDescriptor {
	init(sortDescriptor: NSSortDescriptor) {
		self.init(keyPath: sortDescriptor.key ?? "",
				  ascending: sortDescriptor.ascending)
	}
}


// MARK: - Transforming =================================
import ObjectMapper

class StringIdTransform: TransformType {
	typealias Object = String
	typealias JSON = Int
	
	func transformFromJSON(_ value: Any?) -> Object? {
		if let intValue = value as? Int {
			return String(intValue)
		}
		
		return ""
	}
	
	func transformToJSON(_ value: Object?) -> JSON? {
		if let strValue = value {
			return Int(strValue)
		}
		
		return nil
	}
}

class StringCsvTransform: TransformType {
	typealias Object = String
	typealias JSON = [String]
	
	func transformFromJSON(_ value: Any?) -> Object? {
		if let value = value as? [String] {
			return value.joined(separator: ",")
		}
		
		if let value = value as? [Int] {
			return value.map({ String($0) }).joined(separator: ",")
		}
		
		return ""
	}
	
	func transformToJSON(_ value: Object?) -> JSON? {
		if let value = value {
			return value.components(separatedBy: ",")
		}
		
		return [String]()
	}
}

class ISODateTransform: TransformType {
	typealias Object = Date
	typealias JSON = String
	
	func transformFromJSON(_ value: Any?) -> Date? {
		if let dateStr = value as? String {
			return Date(iso8601String: dateStr)
		}
		
		return nil
	}
	
	func transformToJSON(_ value: Date?) -> String? {
		if let date = value {
			return date.string(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
		}
		
		return nil
	}
}

