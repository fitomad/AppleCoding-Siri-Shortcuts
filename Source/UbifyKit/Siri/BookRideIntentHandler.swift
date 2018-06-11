//
//  BookRideIntentHandler.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 8/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Intents
import Foundation

public class BookRideIntentHandler: NSObject, BookRideIntentHandling
{
    /**
     Comprobamos que todo está listo para resevar un coche
    */
    public func confirm(intent: BookRideIntent, completion: @escaping (BookRideIntentResponse) -> Void) -> Void
    {
        // En Ubify no falla nada y siempre hay coches disponibles
        completion(BookRideIntentResponse(code: .ready, userActivity: nil))
    }
    
    /**
        Reservamos
    */
    public func handle(intent: BookRideIntent, completion: @escaping (BookRideIntentResponse) -> Void) -> Void
    {
        var rideParameters = RideRequestParameter()
        
        rideParameters.origin = intent.origin?.location
        rideParameters.destination = intent.destination?.location
        
        if let payment = intent.payment
        {
            switch payment.type
            {
            case .applePay:
                rideParameters.paymentMethod = PaymentMethod.applePay
            case .debit:
                rideParameters.paymentMethod = PaymentMethod.visa
            default:
                rideParameters.paymentMethod = PaymentMethod.paypal
            }
        }
        
        if let car = intent.car, let identifier = car.identifier, let carType = CarType(rawValue: identifier)
        {
            rideParameters.carType = carType
        }
        
        ///
        rideParameters.rideName = "From Siri Intents"
        
        UbifyClient.shared.request(rideParameters) { (ride: Ride?, error: String?) -> Void in
            if let ride = ride
            {
                let response = BookRideIntentResponse(code: .success, userActivity: nil)
                response.arrivalTime = NSNumber(value: ride.arrivalTime!)
                response.driverName = ride.driver?.name
                response.driverImageURL = ride.driver?.imageURL
                
                completion(response)
            }
            else
            {
                completion(BookRideIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
}
