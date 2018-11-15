import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	/* MARK: Init
	/////////////////////////////////////////// */
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// Styling
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(hex: Constants.Colors.PURPLE_DARK)]
	
		// Local notifications
		let viewFactAction = UIMutableUserNotificationAction()
		viewFactAction.identifier = Constants.LocalNotifications.VIEW_FACT_ACTION_IDENTIFIER
		viewFactAction.title = Constants.LocalNotifications.VIEW_FACT_ACTION_TITLE
		viewFactAction.activationMode = .foreground          // don't bring app to foreground
		viewFactAction.isAuthenticationRequired = false      // don't require unlocking before performing action
	
		let actionCategory = UIMutableUserNotificationCategory()
		actionCategory.identifier = Constants.LocalNotifications.ACTION_CATEGORY_IDENTIFIER
		actionCategory.setActions([viewFactAction], for: .default)     // 4 actions max
		actionCategory.setActions([viewFactAction], for: .minimal)     // for when space is limited - 2 actions max
		
		application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: NSSet(array: [actionCategory]) as? Set<UIUserNotificationCategory>))
		
		return true
	}

	func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
		
		Utils.setRootViewController(viewName: Constants.Views.FACT)
		
		completionHandler() // per developer documentation, app will terminate if we fail to call this
	}
	
	func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
		NotificationCenter.default.post(name: Notification.Name(rawValue: "FactlyShouldRefresh"), object: self)
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		NotificationCenter.default.post(name: Notification.Name(rawValue: "FactlyShouldRefresh"), object: self)
	
		AppDelegate.setupNotifications()
		
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		let todaysDate = formatter.string(from: date)
	
		if UserDefaults.standard.string(forKey: Constants.LocalNotifications.LAST_FACT_DATE) == nil {
			AppDelegate.pullFact()
			UserDefaults.standard.set(todaysDate, forKey: Constants.LocalNotifications.LAST_FACT_DATE)
		}
		else {
			let lastFactDate = UserDefaults.standard.string(forKey: Constants.LocalNotifications.LAST_FACT_DATE)
			
			// Check if 24 hours have passed since the last fact was pulled
			if formatter.date(from: lastFactDate!)! < formatter.date(from: todaysDate)! {
				AppDelegate.pullFact()
				UserDefaults.standard.set(todaysDate, forKey: Constants.LocalNotifications.LAST_FACT_DATE)
			}
		}
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
	
	
	
	/* MARK: Core Functionality
	/////////////////////////////////////////// */
	class func pullFact() {
		let url = "https://opentdb.com/api.php?amount=1&type=multiple"
		Utils.getFact(url, callback: {(params: String, urlContents: String) -> Void in
			if urlContents.characters.count > 5 {
				DispatchQueue.main.async(execute: {
					// Get data
					let result = (urlContents.parseJSONString.value(forKey: "results")! as! NSArray)[0] as! NSDictionary
					let question = result.value(forKey: "question")! as! String
					let answer = result.value(forKey: "correct_answer")! as! String
					
					UserDefaults.standard.set(question, forKey: Constants.Defaults.LATEST_FACT_QUESTION)
					UserDefaults.standard.set(answer, forKey: Constants.Defaults.LATEST_FACT_ANSWER)
					
					AppDelegate.setupNotifications()
				})
			}
		})
	}
	
	class func setupNotifications() {
		// if I have a fact -> add that in the alert!
		var notificationAlertBody = Constants.Strings.NOTIFICATION
		if UserDefaults.standard.string(forKey: Constants.Defaults.LATEST_FACT_QUESTION) != nil {
			notificationAlertBody = UserDefaults.standard.string(forKey: Constants.Defaults.LATEST_FACT_QUESTION)!
		}
		
		// Schedule repeating notification
		let notification = UILocalNotification()
		notification.alertBody = notificationAlertBody
		notification.alertAction = Constants.LocalNotifications.VIEW_FACT_ACTION_TITLE // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
		notification.fireDate = NSDate() as Date  // right now (when notification will be fired)
		notification.soundName = UILocalNotificationDefaultSoundName
		notification.repeatInterval = NSCalendar.Unit.day
		notification.category = Constants.LocalNotifications.ACTION_CATEGORY_IDENTIFIER
		UIApplication.shared.scheduleLocalNotification(notification)
	}
}

