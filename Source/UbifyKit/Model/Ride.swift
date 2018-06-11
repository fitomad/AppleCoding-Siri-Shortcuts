//
//  Ride.swift
//  UberfyKit
//
//  Created by Adolfo Vera Blasco on 6/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation
import CoreLocation

public struct Ride: Codable
{
    ///
    public var rideIdentifier: String?
    
    ///
    public var siriShortcutIdentifier: String?
    
    ///
    public var requestAt: Date
    public var from: Coordinate
    public var destination: Coordinate
    public var car: CarType
    public var paymentMethod: PaymentMethod
    
    public var driver: Driver?
    public var arrivalTime: Int?
    
    /**
 
    */
    public init(requestAt: Date, from: Coordinate, destination: Coordinate, car: CarType, payWith method: PaymentMethod)
    {
        self.requestAt = requestAt
        self.from = from
        self.destination = destination
        self.car = car
        self.paymentMethod = method
    }
    
    /**
 
    */
    public init(requestAt: Date, from: CLLocation, destination: CLLocation, car: CarType, payWith method: PaymentMethod)
    {
        let fromCoordinate = Coordinate(latitude: from.coordinate.latitude , longitude: from.coordinate.longitude)
        let destinationCoordinate = Coordinate(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        
        self.init(requestAt: requestAt,
                  from: fromCoordinate,
                  destination: destinationCoordinate,
                  car: car,
                  payWith: method)
    }
}
