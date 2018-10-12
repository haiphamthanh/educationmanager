//
//  Realm+Extension.swift
//  ASHManager
//
//  Created by HaiPT15 on 6/22/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper
import RealmSwift
import RxSwift

let REALM_SCHEMA_VERSION: UInt64 = 3

//extension Results {
//	func toArray () -> [Object] {
//		var array = [Object]()
//		for result in self {
//			array.append(result)
//		}
//
//		return array
//	}
//}
//
//extension Object {
//	func splitCsv(string: String) -> [String] {
//		return string.characters.split(",").map{ String($0) }
//	}
//
//	static func build<O: Object>(_ builder: (O) -> () ) -> O {
//		let object = O()
//		builder(object)
//
//		return object
//	}
//}
//
//class StringIdTransform: TransformType {
//	typealias Object = String
//	typealias JSON = Int
//
//	func transformFromJSON(value: AnyObject?) -> Object? {
//		if let intValue = value as? Int {
//			return String(intValue)
//		}
//
//		return ""
//	}
//
//	func transformToJSON(value: Object?) -> JSON? {
//		if let strValue = value {
//			return Int(strValue)
//		}
//
//		return nil
//	}
//}
//
//class StringCsvTransform: TransformType {
//	typealias Object = String
//	typealias JSON = [String]
//
//	func transformFromJSON(value: AnyObject?) -> Object? {
//		if let value = value as? [String] {
//			return value.joinWithSeparator(",")
//		} else if let value = value as? [Int] {
//			return value.map({String($0)}).joinWithSeparator(",")
//		}
//
//		return ""
//	}
//
//	func transformToJSON(value: Object?) -> JSON? {
//		if let value = value {
//			return value.componentsSeparatedByString(",")
//		}
//
//		return [String]()
//	}
//}
//
//class ISODateTransform: TransformType {
//	typealias Object = NSDate
//	typealias JSON = String
//
//	func transformFromJSON(value: AnyObject?) -> NSDate? {
//		if let dateStr = value as? String {
//			return NSDate.dateFromISO8601String(dateStr)
//		}
//
//		return nil
//	}
//
//	func transformToJSON(value: NSDate?) -> String? {
//		if let date = value {
//			return date.format("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
//		}
//
//		return nil
//	}
//}

extension SortDescriptor {
	init(sortDescriptor: NSSortDescriptor) {
		self.keyPath = sortDescriptor.key ?? ""
		self.ascending = sortDescriptor.ascending
	}
}

//TODO: Refactor later
//extension Reactive where Base: Realm {
//	func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<R> where R.RealmType: Object  {
//		return Observable.create { observer in
//			do {
//				try self.base.write {
//					self.base.add(entity.asRealm(), update: update)
//				}
//
//				observer.onNext()
//				observer.onCompleted()
//			} catch {
//				observer.onError(error)
//			}
//
//			return Disposables.create()
//		}
//	}
//
//	func save<R: RealmRepresentable>(entity: [R], update: Bool = true) -> Observable<[R]> where R.RealmType: Object  {
//		return Observable.create { observer in
//			do {
//				try self.base.write {
//					self.base.add(entity.asRealm(), update: update)
//				}
//
//				observer.onNext([R])
//				observer.onCompleted()
//			} catch {
//				observer.onError(error)
//			}
//			
//			return Disposables.create()
//		}
//	}
//
//	func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
//		return Observable.create { observer in
//			do {
//				guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else { fatalError() }
//
//				try self.base.write {
//					self.base.delete(object)
//				}
//
//				observer.onNext()
//				observer.onCompleted()
//			} catch {
//				observer.onError(error)
//			}
//
//			return Disposables.create()
//		}
//	}
//}

