import UIKit
import Social

class Fact: UIViewController {
	
	@IBOutlet var bgImageView: UIImageView?
	@IBOutlet var questionAndAnswerLabel: UILabel?
	@IBOutlet var appNameLabel: UILabel?
	@IBOutlet var facebookButton: RoundButton?
	@IBOutlet var twitterButton: RoundButton?
	@IBOutlet var shareButton: RoundButton?
	
	var grayBGView: UIViewController!
	var decodedString: String!

	
	
	/* MARK: Initialising
	/////////////////////////////////////////// */
	override func viewDidLoad() {
		
		// Gray bg view
		grayBGView = UIViewController()
		grayBGView.view.frame = UIScreen.main.bounds
		grayBGView.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		self.view.addSubview(grayBGView.view)
		
		
		// Get & set random picture bg
		let pictures = ["fire", "mountain", "mountains", "night", "night_house", "snow", "watch"]
		let randomPic = pictures[Int(arc4random_uniform(UInt32(pictures.count)))]
		bgImageView?.image = UIImage(named: randomPic)
		
		
		// Button iamges
		facebookButton?.setImage(Utils.imageResize(UIImage(named: "facebook")!, sizeChange: CGSize(width: 22, height: 22)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		twitterButton?.setImage(Utils.imageResize(UIImage(named: "twitter")!, sizeChange: CGSize(width: 21, height: 21)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		shareButton?.setImage(Utils.imageResize(UIImage(named: "share")!, sizeChange: CGSize(width: 22, height: 22)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		
		
		// Bring views to front
		self.view.bringSubview(toFront: questionAndAnswerLabel!)
		self.view.bringSubview(toFront: appNameLabel!)
		self.view.bringSubview(toFront: facebookButton!)
		self.view.bringSubview(toFront: twitterButton!)
		self.view.bringSubview(toFront: shareButton!)
		
		
		
		if UserDefaults.standard.string(forKey: Constants.Common.LATEST_FACT_ANSWER) != nil {
			updateFact()
		}
		
		
		// add observer that will the fact label when a new one is pulled
		UserDefaults.standard.addObserver(self, forKeyPath: Constants.Common.LATEST_FACT_ANSWER, options: NSKeyValueObservingOptions.new, context: nil)
	}
	
	
	
	/* MARK: Observers
	/////////////////////////////////////////// */
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == Constants.Common.LATEST_FACT_ANSWER {
			updateFact()
		}
	}
	
	deinit {
		UserDefaults.standard.removeObserver(self, forKeyPath: Constants.Common.LATEST_FACT_ANSWER)
	}

	
	
	/* MARK: Button Actions
	/////////////////////////////////////////// */
	@IBAction func shareToFacebookButtonPressed(_ sender: UIButton) {
		Utils.post(toService: SLServiceTypeFacebook, view: self, fact: self.decodedString)
	}
	
	@IBAction func shareToTwitterButtonPressed(_ sender: UIButton) {
		Utils.post(toService: SLServiceTypeTwitter, view: self, fact: self.decodedString)
	}
	
	@IBAction func shareButtonPressed(_ sender: UIButton) {
		Utils.share(sender: sender, viewController: self, fact: self.decodedString)
	}
	
	
	
	/* MARK: Core Functionality
	/////////////////////////////////////////// */
	func updateFact() {
		
		// Get data
		var question = UserDefaults.standard.string(forKey: Constants.Common.LATEST_FACT_QUESTION)! as String
		var answer = UserDefaults.standard.string(forKey: Constants.Common.LATEST_FACT_ANSWER)! as String
		
		
		// Decode string
		question = question.replacingOccurrences(of: "&quot;", with: "", options: .literal, range: nil)
		answer = answer.replacingOccurrences(of: "&quot;", with: "", options: .literal, range: nil)
		question = question.removingPercentEncoding!
		answer = answer.removingPercentEncoding!
		self.decodedString = (question + "  =>  " + answer).decode
		

		// Color answer
		let attributedString = NSMutableAttributedString(string: self.decodedString)
		let range = (self.decodedString as NSString).range(of: answer)
		attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: "F6D769"), range: range)
		
		
		self.questionAndAnswerLabel?.attributedText = attributedString
	}
}

