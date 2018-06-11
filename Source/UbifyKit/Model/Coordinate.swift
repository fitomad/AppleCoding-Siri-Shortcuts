//
//  Coordinate.swift
//  UberfyKit
//
//  Created by Adolfo Vera Blasco on 6/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation
import CoreLocation

public struct Coordinate: Codable
{
    public var latitude: Double
    public var longitude: Double
}

extension Coordinate
{
    ///
    public var location: CLLocation
    {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }

    ///
    public var placemark: CLPlacemark
    {
        return CLPlacemark(location: self.location, name: nil, postalAddress: nil)
    }
}
