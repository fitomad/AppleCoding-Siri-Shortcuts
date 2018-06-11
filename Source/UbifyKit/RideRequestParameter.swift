//
//  RideRequestParameter.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 9/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import CoreLocation
import Foundation


public struct RideRequestParameter
{
    ///
    public var origin: CLLocation?
    ///
    public var destination: CLLocation?
    ///
    public var rideName: String?
    ///
    public var paymentMethod: PaymentMethod?
    ///
    public var carType: CarType?
    
    /**
 
    */
    public init()
    {
        self.origin = nil
        self.destination = nil
        self.rideName = nil
        self.paymentMethod = nil
        self.carType = nil
    }
}
