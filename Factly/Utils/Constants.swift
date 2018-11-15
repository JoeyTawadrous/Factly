class Constants {
	
	struct Colors {
		static let PURPLE_DARK = "6A70D6"
	}
	
	
	struct Core {
		static let APP_ID = "1200288775"
		static let APP_NAME = "Factly"
	}
	
	
	struct Defaults {
		static let LATEST_FACT_QUESTION = "lastFactQuestion"
		static let LATEST_FACT_ANSWER = "lastFactAnswer"
	}
	
	
	struct Design {
		static let LOGO = "Logo"
	}
	
	
	struct LocalNotifications {
		static let ACTION_CATEGORY_IDENTIFIER = "ActionCategory"
		static let LAST_FACT_DATE = "lastFactDate"
		static let VIEW_FACT_ACTION_IDENTIFIER = "ViewFactAction"
		static let VIEW_FACT_ACTION_TITLE = "View Fact"
	}
	
	
	struct Strings {
		static let NOTIFICATION = "Fact of the Day 😄"
		
		// Links
		static let LINK_APP_REVIEW = "itms-apps://itunes.apple.com/app/apple-store/id" + Core.APP_ID + "?action=write-review"
		static let LINK_FACEBOOK = "https://www.facebook.com/getlearnable"
		static let LINK_INSTAGRAM = "https://www.instagram.com/learnableapp"
		static let LINK_IOS_STORE = "https://itunes.apple.com/us/app/factly-daily-random-facts/id1200288775?mt=8"
		static let LINK_LEARNABLE_IOS_STORE = "https://itunes.apple.com/gb/app/learnable-learn-to-code-from-scratch-level-up/id1254862243?mt=8"
		static let LINK_TWITTER = "https://twitter.com/getlearnable"
		static let LINK_TWITTER_JOEY = "https://twitter.com/joeytawadrous"
		static let LINK_WEB = "http://www.getlearnable.com"
		
		
		// Send Feedback
		static let EMAIL = "joeytawadrous@gmail.com"
		static let SEND_FEEDBACK_SUBJECT = "Factly Feedback!"
		static let SEND_FEEDBACK_BODY = "I want to make Factly better. Here are my ideas... \n\n What I like about Factly: \n 1. \n 2. \n 3. \n\n What I don't like about Factly: \n 1. \n 2. \n 3. \n\n"
		
		
		// Share
		static let SHARE = "Check out " + Constants.Core.APP_NAME + " on the App Store,where you can learn a new fact 365 days a year. #Factly #iOS \n\nDownload for free now: " + Constants.Strings.LINK_IOS_STORE
	}
	
	struct Views {
		static let FACT = "Fact"
		static let SETTINGS = "Settings"
		static let SETTINGS_NAV_CONTROLLER = "SettingsNavController"
	}
}
