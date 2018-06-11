//
//  IntentHandler.swift
//  UbifyIntents
//
//  Created by Adolfo Vera Blasco on 8/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import os
import Intents

import UbifyKit


class IntentHandler: INExtension
{
    override func handler(for intent: INIntent) -> Any {
        os_log("handler Intents")
        guard intent is BookRideIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        
        return BookRideIntentHandler()
    }
    
}
