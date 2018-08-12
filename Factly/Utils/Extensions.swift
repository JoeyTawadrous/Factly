import Foundation
import UIKit


class RoundButton: UIButton {
	override open func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.size.width / 2
		clipsToBounds = true
		
		layer.backgroundColor = UIColor(hexString: "303338").cgColor
	}
}


extension UIColor {
	convenience init(hexString: String) {
		let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt32()
		Scanner(string: hex).scanHexInt32(&int)
		let a, r, g, b: UInt32
		switch hex.characters.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (1, 1, 1, 0)
		}
		self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
	}
}


extension NSMutableData {
	func appendString(_ string: String) {
		let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
		append(data!)
	}
}


extension String {
	var parseJSONString: NSDictionary {
		let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
		
		if let jsonData = data {
			// Will return an object or nil if JSON decoding fails
			do {
				let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
				return message as! NSDictionary
			}
			catch let error as NSError {
				print("An error occurred: \(error)")
			}
		}
		
		return [:]
	}
	
	var decode: String {
		let nsMutableString = NSMutableString(string: self)
		CFStringTransform(nsMutableString, nil, "Any-Hex/XML10" as CFString, true)
		return nsMutableString as String
	}
}


extension UIFont {
	class func GothamProBold(size: CGFloat) -> UIFont? {
		return UIFont(name: "GothamPro-Bold", size: size)
	}
	
	class func GothamProBlack(size: CGFloat) -> UIFont? {
		return UIFont(name: "GothamPro-Black", size: size)
	}
	
	class func GothamProMedium(size: CGFloat) -> UIFont? {
		return UIFont(name: "GothamPro-Medium", size: size)
	}
	
	class func GothamProRegular(size: CGFloat) -> UIFont? {
		return UIFont(name: "GothamPro-Regular", size: size)
	}
}
