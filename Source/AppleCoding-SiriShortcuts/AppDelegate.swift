//
//  AppDelegate.swift
//  AppleCoding-SiriShortcuts
//
//  Created by Adolfo Vera Blasco on 5/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import os
import UIKit

import UbifyKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Theme.current.tint = .blue
        return true
    }

    //
    // MARK: - Spotlight + NSUserActivity
    //
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        if let intent = userActivity.interaction?.intent as? BookRideIntent
        {
            // Viene de Siri
            let handler = BookRideIntentHandler()
            
            handler.handle(intent: intent) { (response) in
                if response.code != .success
                {
                    os_log("Algo ha pasado con la peticion")
                }
            }
            
            return true
        }
        else if userActivity.activityType == NSUserActivity.bookRideActivityType
        {
            // Viene de Search (Spotlight)
            
            // Resetamos la vista de selección de trayecto...
            
            return true
        }
        
        return false
    }


    override init()
    {
        let defaultData = [
            "USER_ACTIVITY_SHORTCUT_REGISTERED" : false
        ]
        
        UserDefaults.standard.register(defaults: defaultData)
    }
}

