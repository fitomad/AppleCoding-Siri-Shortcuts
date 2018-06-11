//
//  NSUserActivity+Ubify.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 9/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import UIKit
import Foundation
import CoreSpotlight

public extension NSUserActivity
{
    ///
    public static let bookRideActivityType = "com.desappstre.AppleCoding-SiriShortcut.bookRides"
    
    ///
    private static var searchKeywords: [String]
    {
        let keywords = [
            NSLocalizedString("CS_KEYWORD_CAR", bundle: Bundle.ubifyBundle, comment: ""),
            NSLocalizedString("CS_KEYWORD_BOOK", bundle: Bundle.ubifyBundle, comment: ""),
            NSLocalizedString("CS_KEYWORD_RIDE", bundle: Bundle.ubifyBundle, comment: ""),
            NSLocalizedString("CS_KEYWORD_HOME", bundle: Bundle.ubifyBundle, comment: ""),
            NSLocalizedString("CS_KEYWORD_WORK", bundle: Bundle.ubifyBundle, comment: "")
        ]
        
        return keywords
    }
    
    ///
    public static var bookRideActivity: NSUserActivity
    {
        let activity = NSUserActivity(activityType: NSUserActivity.bookRideActivityType)
        
        // User activites should be as rich as possible, with icons and localized strings for appropiate content attributes.
        activity.title = NSLocalizedString("CS_TITLE", bundle: Bundle.ubifyBundle, comment: "View menu activity title")
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        #if os(iOS)
        let attributes = CSSearchableItemAttributeSet(itemContentType: "Solicitar un coche")
        attributes.thumbnailData = UIImage(named: "shortcut")?.pngData() // Used as an icon in Search.
        attributes.keywords = NSUserActivity.searchKeywords
        attributes.displayName = NSLocalizedString("CS_TITLE", bundle: Bundle.ubifyBundle, comment: "View menu activity title")
        let description = NSLocalizedString("CS_DESCRIPTION", bundle: Bundle.ubifyBundle, comment: "View menu content description")
        attributes.contentDescription = description
        
        activity.contentAttributeSet = attributes
        #endif
        
        let phrase = NSLocalizedString("ORDER_LUNCH_SUGGESTED_PHRASE", bundle: Bundle.ubifyBundle, comment: "")
        activity.suggestedInvocationPhrase = phrase
        
        return activity
    }
}
