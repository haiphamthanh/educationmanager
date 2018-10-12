
import Foundation
import UIKit.UIColor

enum Color {
	case crimson
	case darkOrange
	case maroon
	case genkiorange
	
	case custom(hexString: String)
	
	func withAlpha(_ alpha: Double) -> UIColor {
		return self.value.withAlphaComponent(CGFloat(alpha))
	}
}

extension Color {
	var value: UIColor {
		var instanceColor = UIColor.clear
		switch self {
		case .crimson:
			instanceColor = UIColor("#F0225D")
		case .darkOrange:
			instanceColor = UIColor("#F77E35")
		case .maroon:
			instanceColor = UIColor("#D2004C")
		case .genkiorange:
			instanceColor = UIColor("#F07122")
		case .custom(let hexValue):
			instanceColor = UIColor(hexValue)
		}
		return instanceColor
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(red:   .random(),
					   green: .random(),
					   blue:  .random(),
					   alpha: 1.0)
	}
}
