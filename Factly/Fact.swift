import UIKit
import Social

class Fact: UIViewController {
	
	@IBOutlet var bgImageView: UIImageView?
	@IBOutlet var questionAndAnswerLabel: UILabel?
	@IBOutlet var appNameLabel: UILabel?
	@IBOutlet var facebookButton: RoundButton?
	@IBOutlet var twitterButton: RoundButton?
	@IBOutlet var shareButton: RoundButton?
	@IBOutlet var refreshFactButton: UIButton!
	@IBOutlet var menuButton: UIButton!
	
	
	var grayBGView: UIViewController!
	var decodedString: String!

	
	
	/* MARK: Initialising
	/////////////////////////////////////////// */
	override func viewDidLoad() {
		// Styling
		menuButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
		menuButton.setTitle(String.fontAwesomeIcon(name: .bars), for: .normal)
		refreshFactButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
		refreshFactButton.setTitle(String.fontAwesomeIcon(name: .redo), for: .normal)
		
		
		// Gray bg view
		grayBGView = UIViewController()
		grayBGView.view.frame = UIScreen.main.bounds
		grayBGView.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		self.view.addSubview(grayBGView.view)
		
		
		// Button iamges
		facebookButton?.setImage(Utils.imageResize(UIImage(named: "facebook")!, sizeChange: CGSize(width: 22, height: 22)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		twitterButton?.setImage(Utils.imageResize(UIImage(named: "twitter")!, sizeChange: CGSize(width: 21, height: 21)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		shareButton?.setImage(Utils.imageResize(UIImage(named: "share")!, sizeChange: CGSize(width: 22, height: 22)).withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
		
		
		// Bring views to front
		self.view.bringSubview(toFront: refreshFactButton!)
		self.view.bringSubview(toFront: menuButton!)
		self.view.bringSubview(toFront: questionAndAnswerLabel!)
		self.view.bringSubview(toFront: appNameLabel!)
		self.view.bringSubview(toFront: facebookButton!)
		self.view.bringSubview(toFront: twitterButton!)
		self.view.bringSubview(toFront: shareButton!)
		
		if UserDefaults.standard.string(forKey: Constants.Defaults.LATEST_FACT_ANSWER) != nil {
			updateFact()
		}
		
		
		// Add observer that will the fact label when a new one is pulled
		UserDefaults.standard.addObserver(self, forKeyPath: Constants.Defaults.LATEST_FACT_ANSWER, options: NSKeyValueObservingOptions.new, context: nil)
	}
	
	override func viewWillLayoutSubviews() {
		// Get & set random picture bg
		let pictures = ["fire", "mountain", "mountains", "night", "night_house", "snow", "watch"]
		let randomPic = pictures[Int(arc4random_uniform(UInt32(pictures.count)))]
		bgImageView?.image = UIImage(named: randomPic)
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	
	/* MARK: Observers
	/////////////////////////////////////////// */
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == Constants.Defaults.LATEST_FACT_ANSWER {
			updateFact()
		}
	}
	
	deinit {
		UserDefaults.standard.removeObserver(self, forKeyPath: Constants.Defaults.LATEST_FACT_ANSWER)
	}

	
	
	/* MARK: Button Actions
	/////////////////////////////////////////// */
	@IBAction func refreshFactButtonPressed(_ sender: AnyObject) {
		AppDelegate.pullFact()
		updateFact()
	}
	
	@IBAction func menuButtonPressed(_ sender: AnyObject) {
		Utils.presentView(self, viewName: Constants.Views.SETTINGS_NAV_CONTROLLER)
	}
	
	@IBAction func shareToFacebookButtonPressed(_ sender: UIButton) {
		Utils.post(toService: SLServiceTypeFacebook, view: self, fact: self.decodedString)
	}
	
	@IBAction func shareToTwitterButtonPressed(_ sender: UIButton) {
		Utils.post(toService: SLServiceTypeTwitter, view: self, fact: self.decodedString)
	}
	
	@IBAction func shareButtonPressed(_ sender: UIButton) {
		Utils.openShareView(viewController: self, fact: self.decodedString)
	}
	
	
	
	/* MARK: Core Functionality
	/////////////////////////////////////////// */
	func updateFact() {
		// Get data
		let question = UserDefaults.standard.string(forKey: Constants.Defaults.LATEST_FACT_QUESTION)! as String
		let answer = UserDefaults.standard.string(forKey: Constants.Defaults.LATEST_FACT_ANSWER)! as String
		
		// Decode string
		self.decodedString = (question + "\n\nAnswer: " + answer).decode
		questionAndAnswerLabel?.text = self.decodedString
		
		// show buttons
		facebookButton?.isHidden = false
		twitterButton?.isHidden = false
		shareButton?.isHidden = false
	}
}
