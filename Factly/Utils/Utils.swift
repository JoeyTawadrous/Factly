import Social

class Utils {
	
	
	
	/* MARK: Images
	/////////////////////////////////////////// */
	class func imageResize (_ image:UIImage, sizeChange:CGSize) -> UIImage{
		let hasAlpha = true
		let scale: CGFloat = 0.0 // Use scale factor of main screen
		
		UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
		image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
		
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		return scaledImage!
	}
	
	
	
	// MARK: POST
	/////////////////////////////////////////// */
	class func getFact(_ queryURL: String, callback: @escaping (_ queryURL: String, _ urlContents: String) -> Void) {
		let url = URL(string: queryURL)
		var request = URLRequest(url: url!)
		
		let session = URLSession.shared
		
		request.httpBody = queryURL.data(using: String.Encoding.utf8)
		request.httpMethod = "POST"
		
		let task = session.downloadTask(with: request, completionHandler: {(location, response, error) in
			guard let _:URL = location, let _:URLResponse = response, error == nil else {
				return
			}
			let urlContents: String = try! NSString(contentsOf: location!, encoding: String.Encoding.utf8.rawValue) as String
			guard let _:NSString = urlContents as NSString? else {
				return
			}
			
			callback(queryURL, urlContents)
		})
		
		task.resume()
	}
	
	
	
	// MARK: Social
	/////////////////////////////////////////// */
	class func post(toService service: String, view: UIViewController, fact: String) {
		if(SLComposeViewController.isAvailable(forServiceType: service)) {
			let socialController = SLComposeViewController(forServiceType: service)
			
			if service == "com.apple.social.facebook" {
				socialController?.setInitialText(fact + "\n\n" + Constants.Strings.SHARE)
			}
			else if service == "com.apple.social.twitter" {
				socialController?.setInitialText(Constants.Strings.SHARE)
			}
			
			view.present(socialController!, animated: true, completion: nil)
		}
		else {
			Utils.presentOkButtonAlert(view, message: "Please ensure you are logged into Facebook / Twitter in your devices settings before you try to post.")
		}
	}
	
	class func openURL(url: String) {
		let url = URL(string: url)!
		if #available(iOS 10.0, *) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		} else {
			UIApplication.shared.openURL(url)
		}
	}
	
	class func share(sender: UIButton, viewController: UIViewController, fact: String) {
		let share = fact + "\n" + Constants.Strings.SHARE
		let link : NSURL = NSURL(string: Constants.Common.APP_STORE_LINK)! // TODO: put bitly url here when app on store
		let logo: UIImage = UIImage(named: "AppIcon")!
		
		let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [share, link, logo], applicationActivities: nil)
		
		// This lines is for the popover you need to show in iPad
		activityViewController.popoverPresentationController?.sourceView = sender
		
		// This line remove the arrow of the popover to show in iPad
		activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
		activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
		
		// Anything you want to exclude
		activityViewController.excludedActivityTypes = [
			UIActivityType.postToWeibo,
			UIActivityType.print,
			UIActivityType.assignToContact,
			UIActivityType.saveToCameraRoll,
			UIActivityType.addToReadingList,
			UIActivityType.postToFlickr,
			UIActivityType.postToVimeo,
			UIActivityType.postToTencentWeibo
		]
		
		viewController.present(activityViewController, animated: true, completion: nil)
	}
	
	
	
	// MARK: Visual
	/////////////////////////////////////////// */
	class func getViewController(_ viewName: String) -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: viewName) as UIViewController
		return vc
	}
	
	class func presentView(_ view: UIViewController, viewName: String) {
		view.present(getViewController(viewName), animated: true, completion: nil)
	}
	
	class func pushView(_ view: UIViewController, viewName: String) {
		view.navigationController?.pushViewController(getViewController(viewName), animated: true)
	}
	
	class func setRootViewController(viewName: String) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window?.rootViewController = getViewController(viewName)
	}
	
	class func dismissView(_ view: UIViewController) {
		let presentingViewController: UIViewController! = view.presentingViewController
		
		view.dismiss(animated: false) {
			presentingViewController.dismiss(animated: true, completion: nil)
		}
	}
	
	class func presentOkButtonAlert(_ view: UIViewController, message: String) {
		let alert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
		
		view.present(alert, animated: true, completion: nil)
	}
}
