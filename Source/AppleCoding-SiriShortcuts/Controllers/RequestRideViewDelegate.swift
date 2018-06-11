//
//  RequestRideViewDelegate.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 28/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation
import CoreLocation

import UbifyKit

internal protocol RequestRideViewDelegate: AnyObject
{
    /**

    */
    func requestController(_ request: RequestRideViewController, didFinishRequestRide ride: RideRequestParameter) -> Void
    
    /**

    */
    func requestControllerDidCancel(_ request: RequestRideViewController) -> Void

    /**

    */
    func requestController(_ request: RequestRideViewController, didSelectDestination location: CLLocation) -> Void
}
