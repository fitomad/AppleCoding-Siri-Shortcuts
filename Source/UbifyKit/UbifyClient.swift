//
//  UbifyClient.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 9/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

public typealias UbifyCompletionHandler = (_ result: Ride?, _ error: String?) -> Void

public class UbifyClient
{
    public static let shared = UbifyClient()
    
    private init()
    {
        
    }
    
    public func request(_ parameter: RideRequestParameter, handler: @escaping UbifyCompletionHandler) -> Void
    {
        guard let origin = parameter.origin, let destination = parameter.destination else
        {
            handler(nil, "Faltan el origen y el destino para calcular un trayecto")
            return
        }
        
        guard let paymentMethod = parameter.paymentMethod else
        {
            handler(nil, "Necesitamos una forma de pago donde facturar el coste del trayecto")
            return
        }
        
        var rideCarType: CarType = .electric
        
        if let carType = parameter.carType
        {
            rideCarType = carType
        }
        
        let driver = self.makeDriver()
        
        let now = Date()
        
        var ride = Ride(requestAt: now,
                        from: origin,
                        destination: destination,
                        car: rideCarType,
                        payWith: paymentMethod)
        
        ride.driver = driver
        ride.arrivalTime = Int.random(in: 5...11)
        handler(ride, nil)
    }
    
    //
    // MARK: - Driver
    //
    
    private func makeDriver() -> Driver
    {
        let isMale = Bool.random()
        
        return isMale ? self.makeMaleDriver() : self.makeFemaleDriver()
    }
    
    private func makeMaleDriver() -> Driver
    {
        let number = Int.random(in: 0...3)
        
        let names = ["Kyle Harris", "Michael Martinez", "Wayne Ward", "Steven Cole"]
        
        return Driver(name: names[number], imageURL: "m\(number)")
    }
    
    private func makeFemaleDriver() -> Driver
    {
        let number = Int.random(in: 0...3)
        
        let names = [ "Shirley Gilbert", "Tammy Vargas", "Madison Owens", "Emma Smith" ]
        
        return Driver(name: names[number], imageURL: "f\(number)")
    }
    
    /**
     
     */
    private func arrivalTime() -> Int
    {
        return Int.random(in: 2...9)
    }
    
    
}
