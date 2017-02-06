
class Constants {
	
	struct Common {
		static let LATEST_FACT_QUESTION = "lastFactQuestion"
		static let LATEST_FACT_ANSWER = "lastFactAnswer"
		static let APP_STORE_LINK = ""
	}
	
	struct LocalNotifications {
		static let ACTION_CATEGORY_IDENTIFIER = "ActionCategory"
		static let LAST_FACT_DATE = "lastFactDate"
		static let SCHEDULED_DAILY_NOTIFICATION = "scheduledDailyNotification"
		static let VIEW_FACT_ACTION_IDENTIFIER = "ViewFactAction"
		static let VIEW_FACT_ACTION_TITLE = "View Fact"
	}
	
	struct Strings {
		static let SHARE = "Check out Factly on the App Store, where you can learn a new fact 365 days a year! " + Constants.Common.APP_STORE_LINK
		static let NOTIFICATION = "A new fact is ready for you! 😄 (Resets in 24 hours)"
	}
	
	struct Views {
		static let FACT = "Fact"
	}
	
	struct Web {
		static let HOST_DIR = "http://localhost:8888/Factly/"
//		static let HOST_DIR = "http://applandr.com/Yellow/"
		static let ACTIONS_DOT_PHP = HOST_DIR + "actions.php"
		static let EMAIL = "joeytawadrous@gmail.com"
	}
}
