//
//  ResponseRideViewDelegate.swift
//  AppleCoding-SiriShortcuts
//
//  Created by Adolfo Vera Blasco on 10/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

internal protocol ResponseRideViewDelegate: AnyObject
{
    /**
 
    */
    func responseController(_ controller: ResponseRideViewController, didRequestSiriVoiceForShortcut identifier: String) -> Void
    
    /**
 
    */
    func responseController(_ controller: ResponseRideViewController, didCancelSiriDonation identifier: String) -> Void
}
