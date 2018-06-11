//
//  Storage.swift
//  UberfyKit
//
//  Created by Adolfo Vera Blasco on 6/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Intents
import Foundation

public class Storage
{
    ///
    public static let shared = Storage()
    
    ///
    private lazy var database: [String: Codable] = {
        return [String: Codable]()
    }()
    
    /**
 
    */
    private init()
    {
        
    }
    
    /**
 
    */
    public func add(_ element: Codable, forKey key: String) -> Void
    {
        
    }
    
    /**
 
    */
    public func remove(forKey: String) -> Void
    {
        
    }
}

extension Storage
{
    private func donate(ride: Ride) -> Void
    {
        let paymentMethod = INPaymentMethod.applePay()
        let intent = BookRideIntent()
        
        intent.payment = paymentMethod
        //intent.destination = ride.destination
        
        
    }
}
