import UIKit


class RoundButton: UIButton {
	override open func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.size.width / 2
		clipsToBounds = true
		
		layer.backgroundColor = UIColor(hex: "303338").cgColor
	}
}
