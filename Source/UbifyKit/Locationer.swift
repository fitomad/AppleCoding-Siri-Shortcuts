//
//  Locationer.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 29/4/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation
import CoreLocation

/**
    Closure donde devolvemos la dirección basada
    en unas coordenadas
*/
public typealias AddressCompletionHandler = (_ address: CLPlacemark?) -> Void

public class Locationer
{
    /// Singleton
    public static let shared: Locationer = Locationer()
    
    /// Edificio España (Cuando lo remodelen)
    public let homeLocation: CLLocation
    
    /// CBTA
    public let workLocation: CLLocation
    
    /// Puerta Cerrada
    public let myLocationOne: CLLocation
    
    /// AZCA
    public let myLocationTwo: CLLocation
    
    /**
        Preparamos el manager y gestionamos la
        autorización a la localización
    */
    private init()
    {
        self.homeLocation = CLLocation(latitude: 40.4226939, longitude: -3.7102467)
        self.workLocation = CLLocation(latitude: 40.4775249, longitude: -3.6898207)
        self.myLocationOne = CLLocation(latitude: 40.413022, longitude: -3.7090227)
        self.myLocationTwo = CLLocation(latitude: 40.451592, longitude: -3.692892)
    }
    
    //
    // MARK: - Helper
    //
    
    /**
        Crea una dirección a partir de unas coordenadas

        - Parameters:
            - location: Las coordenadas de las que vamos a 
                obtener una dirección
            - handler: Closure donde devolvemos el resultado
    */
    public func makeAddress(from location: CLLocation, handler: @escaping AddressCompletionHandler) -> Void
    {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: Error?) -> Void in
            guard let placemarks = placemarks, let placemark = placemarks.first else
            {
                return
            }
            
            handler(placemark)
        }
    }
}
