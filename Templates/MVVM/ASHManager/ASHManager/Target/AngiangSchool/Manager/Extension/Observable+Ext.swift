import Foundation
import RxSwift

//extension Observable where Element: Sequence, Element.Iterator.Element: LocalDataConvertibleType {
//	typealias LocalType = Element.Iterator.Element.LocalType
//
//	func mapToLocal() -> Observable<[LocalType]> {
//		return map { sequence -> [LocalType] in
//			return sequence.mapToDomain()
//		}
//	}
//}
//
//extension Sequence where Iterator.Element: LocalDataConvertibleType {
//	typealias Element = Iterator.Element
//	func mapToLocal() -> [Element.LocalType] {
//		return map {
//			return $0.asLocal()
//		}
//	}
//}
