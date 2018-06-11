//
//  RideMapViewController.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 28/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import os
import UIKit
import MapKit
import Intents
import IntentsUI
import Foundation

import UbifyKit

internal class RideMapViewController: UIViewController
{
    ///
    @IBOutlet private weak var mapView: MKMapView!
    ///
    @IBOutlet private weak var containerRequest: UIView!
    ///
    @IBOutlet private weak var containerResponse: UIView!

    ///
    private var controllerRequest: RequestRideViewController?
    ///
    private var controllerResponse: ResponseRideViewController?
    
    private var intent: BookRideIntent?

    //
    // MARK: - Life Cycle
    //

    /**

    */
    override internal func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        
        // Siri Shortcut
        // Este Shortcut se limita a abrir la app
        // Ejemplo usando el API `NSUserActivity`
        
        if !UserDefaults.standard.bool(forKey: "USER_ACTIVITY_SHORTCUT_REGISTERED")
        {
            self.userActivity = NSUserActivity.bookRideActivity
            
            UserDefaults.standard.set(true, forKey: "USER_ACTIVITY_SHORTCUT_REGISTERED")
        }
    }

    /**

    */
    override internal func viewWillAppear(_ animated: Bool) -> Void
    {
        super.viewWillAppear(animated)

        self.prepareMap()
        self.locateControllers()
    }

    /**

    */
    override internal func viewDidAppear(_ animated: Bool) -> Void
    {
        super.viewDidAppear(animated)

        self.prepareMap()
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) -> Void
    {
        guard let segueIdentifier = segue.identifier else
        {
            return
        }
        
        if segueIdentifier == "MapRequestSegue"
        {
            self.controllerRequest = segue.destination as? RequestRideViewController
            self.controllerRequest?.delegate = self
        }
        
        if segueIdentifier == "MapResponseSegue"
        {
            self.controllerResponse = segue.destination as? ResponseRideViewController
            self.controllerResponse?.delegate = self
        }
    }

    //
    // MARK: - Prepare UI
    //

    /**

    */
    private func locateControllers() -> Void
    {
        let requestFrame = CGRect(x: 0.0, 
            y: self.view.bounds.height - 150.0, 
            width: self.containerRequest.bounds.width,
            height: self.containerRequest.bounds.height)

        self.containerRequest.frame = requestFrame
        
        let responseFrame = CGRect(x: 0.0,
                                   y: self.view.bounds.height,
                                   width: self.containerResponse.bounds.width,
                                   height: self.containerResponse.bounds.height)
        
        self.containerResponse.frame = responseFrame
    }

    private func prepareMap() -> Void
    {
        self.mapView.delegate = self
        
        self.mapView.setCenter(Locationer.shared.myLocationOne.coordinate, animated: true)

        let originAnnotation = UbifyMapAnnotation(at: Locationer.shared.myLocationOne, isOrigin: true)
        self.mapView.addAnnotation(originAnnotation)
    }

    //
    // MARK: - Animations
    //

    private func presentRequestForm() -> Void
    {
        let translation = -(self.containerRequest.bounds.height - 155.0)
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeInOut)

        animator.addAnimations() {
            self.containerRequest.transform = CGAffineTransform(translationX: 0.0, y: translation)
        }
        
        animator.startAnimation()
    }

    /**

    */
    private func hideRequestForm() -> Void
    {
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeIn)

        animator.addAnimations() {
            self.containerRequest.transform = CGAffineTransform.identity
        }
        
        animator.startAnimation()
    }
    
    /**
 
    */
    private func presentResponseForm() -> Void
    {
        let translation = -(self.containerResponse.bounds.height)
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeInOut)
        
        animator.addAnimations() {
            self.containerResponse.transform = CGAffineTransform(translationX: 0.0, y: translation)
        }
        
        animator.startAnimation()
    }
    
    /**
     
     */
    private func hideResponseForm() -> Void
    {
        let animator = UIViewPropertyAnimator(duration: 0.35, curve: .easeIn)
        
        animator.addAnimations() {
            self.containerResponse.transform = CGAffineTransform.identity
        }
        
        animator.startAnimation()
    }
}

//
// MARK: - RequestRideViewDelegate Protocol
//

extension RideMapViewController: RequestRideViewDelegate
{
    /**

    */
    func requestController(_ request: RequestRideViewController, didFinishRequestRide ride: RideRequestParameter) -> Void
    {
        UbifyClient.shared.request(ride, handler: { (ride: Ride?, error: String?) -> Void in
            var showResponse = false
            
            if var ride = ride
            {
                self.intent = self.performSiriDonation(with: &ride)
                
                showResponse = true
                self.controllerResponse?.ride = ride
            }
            else if let error = error
            {
                os_log("UbifyClient.Error %@", error)
            }
            
            self.hideRequestForm()
            
            if showResponse
            {
                self.presentResponseForm()
            }
        })
        
        
    }
    
    /**
     
     */
    func requestControllerDidCancel(_ request: RequestRideViewController) -> Void
    {
        self.hideRequestForm()
    }

    /**

    */
    func requestController(_ request: RequestRideViewController, didSelectDestination location: CLLocation) -> Void
    {
        // Quitamos la anotación del anterior destino si lo hubiera
        let olderDestination = self.mapView.annotations.map({ $0 as! UbifyMapAnnotation }).filter({ $0.isOrigin == false }).first
        
        if let olderDestination = olderDestination
        {
            self.mapView.removeAnnotation(olderDestination)
        }

        // Añadimos el nuevo destino
        let destinationAnnotation = UbifyMapAnnotation(at: Locationer.shared.myLocationOne, isOrigin: false)
        self.mapView.addAnnotation(destinationAnnotation)

        self.presentRequestForm()
    }
}

//
// MARK: - ResponseRideViewDelegate Protocol
//

extension RideMapViewController: ResponseRideViewDelegate
{
    /**
 
    */
    func responseController(_ controller: ResponseRideViewController, didRequestSiriVoiceForShortcut identifier: String) -> Void
    {
        if let intent = self.intent, let shortcut = INShortcut(intent: intent)
        {
            let voiceShortcutController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            voiceShortcutController.delegate = self
            present(voiceShortcutController, animated: true, completion: nil)
            
            self.hideResponseForm()
        }
    }
    
    /**
     
     */
    func responseController(_ controller: ResponseRideViewController, didCancelSiriDonation identifier: String) -> Void
    {
        INInteraction.delete(with: [ identifier ], completion: { (error: Error?) -> Void in
            if let error = error
            {
                os_log("Error al borrar la donación. %@", error.localizedDescription)
            }
            else
            {
                os_log("Donación borrada")
            }
        })
        
        self.hideResponseForm()
    }
}

//
// MARK: - MKMapViewDelegate Protocol
//

extension RideMapViewController: MKMapViewDelegate
{
    /**

    */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        guard let annotation = annotation as? UbifyMapAnnotation else 
        {
            return nil
        }

        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "UbifyAnnotationView")
        annotationView.markerTintColor = annotation.annotationColor
        annotationView.animatesWhenAdded = true

        return annotationView
    }
}

//
// MARK: - Siri Donation
//

extension RideMapViewController
{
    /**
 
    */
    private func performSiriDonation(with ride: inout Ride) -> BookRideIntent?
    {
        // Y aquí es donde *donamos* el shortcut a Siri.
        // De esta manera Siri aprende sobre nuestras costumbres
        // en la app para luego poder hacer las recomendaciones
        
        let shortcut = BookRideIntent()
        
        switch ride.paymentMethod
        {
        case .applePay:
            shortcut.payment = INPaymentMethod.applePay()
            
        case .paypal:
            shortcut.payment = INPaymentMethod(type: .checking, name: "PayPal", identificationHint: nil, icon: nil)
            
        case .visa:
            shortcut.payment = INPaymentMethod(type: .credit, name: "Visa", identificationHint: nil, icon: nil)
        }
        
        shortcut.origin = CLPlacemark(location: ride.from.location, name: "Origen", postalAddress: nil)
        shortcut.destination = CLPlacemark(location: ride.destination.location, name: "Destino", postalAddress: nil)
        //shortcut.destinationName = "Allí"
        
        shortcut.car = INObject(identifier: ride.car.rawValue, display: ride.car.localizedString)
        
        if let image = UIImage(named: "Shortcut"), let data = image.pngData()
        {
            shortcut.setImage(INImage(imageData: data), forParameterNamed: "destination")
        }
        
        shortcut.suggestedInvocationPhrase = "Pide un coche"
        
        ride.siriShortcutIdentifier = shortcut.identifier
        
        let interaction = INInteraction(intent: shortcut, response: nil)
        interaction.donate() { (error: Error?) -> Void in
            if let error = error
            {
                os_log("%@", error.localizedDescription)
            }
            else
            {
                os_log("Shortcut donated")
            }
        }
        
        return shortcut
    }
}

//
// MARK: - INUIAddVoiceShortcutViewControllerDelegate Protocol
//

extension RideMapViewController: INUIAddVoiceShortcutViewControllerDelegate
{
    /**
 
    */
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) -> Void
    {
        os_log("Siri Shortcut Voice... DONE")
        controller.dismiss(animated: true, completion: nil)
    }
    
    /**
 
    */
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) -> Void
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
