//
//  UbifyMapAnnotation.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 10/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

public class UbifyMapAnnotation: NSObject, MKAnnotation
{
    ///
    public private(set) var isOrigin: Bool
    ///
    public private(set) var location: CLLocation

    //
    // MARK: - MKAnnotation Protocol
    //
    
    public var coordinate: CLLocationCoordinate2D
    {
        return self.location.coordinate
    }
    
    //
    // MARK: - Custom Properties
    //

    /// Color asociado al nivel de ocupación
    public var annotationColor: UIColor
    {
        let originColor = UIColor(red: 0.71, green: 0.99, blue: 0.16, alpha: 1.0)
        let destinationColor = UIColor(red: 1.0, green: 0.31, blue: 0.47, alpha: 1.0)

        return self.isOrigin ? originColor : destinationColor
    }

    /**
        Annotation basada en una estación 
    */
    public init(at location: CLLocation, isOrigin: Bool)
    {
        self.location = location
        self.isOrigin = isOrigin
    }
}
