import Foundation
import Moya
import RxSwift
import ObjectMapper

enum ASEError: String {
	case couldNotParseJSON
	case notLoggedIn
	case missingData
}

extension ASEError: Swift.Error { }

extension Observable {
	
	typealias Dictionary = [String: AnyObject]
	
	/// Get given JSONified data, pass back objects
	func mapTo<B: ImmutableMappable>(object classType: B.Type) -> Observable<B> {
		return self.map { json in
			guard let dict = json as? Dictionary else {
				throw ASEError.couldNotParseJSON
			}
			
			return try Mapper<B>().map(JSONObject: dict)
		}
	}
	
	/// Get given JSONified data, pass back objects as an array
	func mapTo<B: ImmutableMappable>(arrayOf classType: B.Type) -> Observable<[B]> {
		return self.map { json in
			guard let array = json as? [AnyObject] else {
				throw ASEError.couldNotParseJSON
			}
			
			guard let dicts = array as? [Dictionary] else {
				throw ASEError.couldNotParseJSON
			}
			
			return try Mapper<B>().mapArray(JSONArray: dicts)
		}
	}
}
