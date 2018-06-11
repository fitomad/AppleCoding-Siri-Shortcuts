//
//  IntentViewController.swift
//  UbifyIntentsUI
//
//  Created by Adolfo Vera Blasco on 8/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import os
import IntentsUI

import UbifyKit

internal class IntentViewController: UIViewController, INUIHostedViewControlling
{
    ///
    @IBOutlet private weak var labelRideAmount: UILabel!
    ///
    @IBOutlet private weak var labelRideAdvice: UILabel!
    ///
    @IBOutlet private weak var labelDriverName: UILabel!
    ///
    @IBOutlet private weak var labelDriverAdvice: UILabel!
    ///
    @IBOutlet private weak var labelArrivalAdvice: UILabel!
    ///
    @IBOutlet private weak var labelArrivalTime: UILabel!
    ///
    @IBOutlet private weak var imageDriver: UIImageView!
    
    ///
    internal var desiredSize: CGSize
    {
        return CGSize(width: 320.0, height: 297)
    }
    
    /**
 
    */
    override internal func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        os_log("viewDidLoad IntentViewController")
    }
    
    
    
    /**
        Preparamos el UI del Intent en función de su estado
    */
    internal func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void)
    {
        // Fase de confirmación
        if interaction.intentHandlingStatus == .ready
        {
            if let intent = interaction.intent as? BookRideIntent
            {
                var mensaje = "Coche con destino a "
                
                if let destino = intent.destination?.name
                {
                    mensaje += destino
                }
                
                if let car = intent.car, let identifier = car.identifier, let carType = CarType(rawValue: identifier)
                {
                    mensaje += " en un \(carType.localizedString) "
                }
                
                if let payment = intent.payment, let paymentName = payment.name
                {
                    mensaje += "pagando con \(paymentName)"
                }
                
                self.labelArrivalAdvice.text = mensaje
                self.labelArrivalTime.text = ""
            }
            
            completion(true, parameters, CGSize(width: 320.0, height: 100.0))
        }
        
        
        // Fase de "éxito". Ocurre tras darle al botón "Reservar"
        if interaction.intentHandlingStatus == .success
        {
            if let response = interaction.intentResponse as? BookRideIntentResponse
            {
                self.labelArrivalAdvice.text = "Dependiendo del tráfico puedo haber algún retraso. Gracias por tu paciencia."
                self.labelRideAdvice.text = "El precio incluye el 21% de IVA junto con una botella de agua."
                
                if let driverName = response.driverName
                {
                    self.labelDriverName.text = driverName
                }
                
                if let arrivalTime = response.arrivalTime
                {
                    self.labelArrivalTime.text = "\(arrivalTime) min"
                }
                
                if let imageURL = response.driverImageURL
                {
                    self.imageDriver.image = UIImage(named: imageURL)
                }
                
                completion(true, parameters, self.desiredSize)
            }
            else
            {
                completion(true, parameters, CGSize.zero)
            }
        }
    }
}
