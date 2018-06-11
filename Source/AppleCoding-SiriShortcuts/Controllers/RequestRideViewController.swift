//
//  RequestRideViewController.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 28/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import os
import UIKit
import Foundation
import CoreLocation


import UbifyKit

internal class RequestRideViewController: UIViewController
{
    ///
    @IBOutlet private weak var stackViewGo: UIStackView!
    ///
    @IBOutlet private weak var buttonGoHome: UIButton!
    ///
    @IBOutlet private weak var buttonGoWork: UIButton!

    ///
    @IBOutlet private weak var stackViewCar: UIStackView!
    ///
    @IBOutlet private weak var buttonCarElectric: UIButton!
    ///
    @IBOutlet private weak var buttonCarExecutive: UIButton!
    ///
    @IBOutlet private weak var buttonCarGroup: UIButton!

    ///
    @IBOutlet private weak var stackViewPay: UIStackView!
    ///
    @IBOutlet private weak var buttonPayApplePay: UIButton!
    ///
    @IBOutlet private weak var buttonPayVisa: UIButton!
    ///
    @IBOutlet private weak var buttonPayPayPal: UIButton!

    ///
    @IBOutlet private weak var labelPriceAmount: UILabel!
    ///
    @IBOutlet private weak var labelPriceDetails: UILabel!

    ///
    @IBOutlet private weak var buttonRequestRide: UIButton!

    ///
    internal weak var delegate: RequestRideViewDelegate?
    
    private var rideParameters: RideRequestParameter?

    //
    // MARK: - Life Cycle
    //

    /**

    */
    override internal func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        
        self.rideParameters = RideRequestParameter()
        self.rideParameters?.origin = Locationer.shared.myLocationOne
    }

    /**

    */
    override internal func viewWillAppear(_ animated: Bool) -> Void
    {
        super.viewWillAppear(animated)

        self.applyTheme()
        self.localizedText()
    }

    //
    // MARK: - Prepare UI
    //

    /**

    */
    private func applyTheme() -> Void
    {
        self.view.backgroundColor = Theme.current.backgroundColor
        self.view.layer.cornerRadius = 16.0
        self.view.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner ]

        [ self.buttonGoHome, self.buttonCarElectric, self.buttonPayPayPal ].forEach({
            $0?.layer.cornerRadius = 8.0
            $0?.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMinXMaxYCorner ]
            self.applyUnselectedTheme(to: $0!)
        })
        
        [ self.buttonGoWork, self.buttonCarExecutive, self.buttonPayApplePay ].forEach({
            $0?.layer.cornerRadius = 8.0
            $0?.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
            self.applyUnselectedTheme(to: $0!)
        })
        
        [ self.buttonCarGroup, self.buttonPayVisa ].forEach({
            self.applyUnselectedTheme(to: $0!)
        })

        
        self.buttonRequestRide.backgroundColor = Theme.current.tintColor
        self.buttonRequestRide.tintColor = Theme.current.backgroundColor
        self.buttonRequestRide.layer.cornerRadius = 8.0
        self.buttonRequestRide.layer.masksToBounds = true
    }
    
    private func localizedText() -> Void
    {
        
    }

    /**

    */
    private func applyUnselectedTheme(to button: UIButton) -> Void
    {
        button.backgroundColor = Theme.current.secondaryBackgroundColor
        button.tintColor = Theme.current.secondaryTextColor
    }

    /**

    */
    private func applySelectedTheme(to button: UIButton) -> Void
    {
        button.backgroundColor = Theme.current.tintColor
        button.tintColor = Theme.current.backgroundColor
    }

    //
    // MARK: - Animation
    //

    /**

    */
    private func transition(to newSelectedButton: UIButton, from oldSelectedButton: UIButton?) -> Void
    {
        let animator = UIViewPropertyAnimator(duration: 0.45, curve: .easeOut)

        animator.addAnimations() {
            if let oldSelectedButton = oldSelectedButton
            {
                self.applyUnselectedTheme(to: oldSelectedButton)
            }
            
            self.applySelectedTheme(to: newSelectedButton)
        }

        animator.startAnimation()
    }

    //
    // MARK: - Actions
    //

    /**

    */
    @IBAction private func handleGoButtonTap(sender: UIButton) -> Void
    {
        if sender === self.buttonGoHome
        {
            self.transition(to: sender, from: self.buttonGoWork)
            
            self.rideParameters?.destination = Locationer.shared.homeLocation
            self.rideParameters?.rideName = "Casa"
        }
        else
        {
            self.transition(to: sender, from: self.buttonGoHome)
            self.rideParameters?.destination = Locationer.shared.workLocation
            self.rideParameters?.rideName = "Trabajo"
        }  

        if let rideParameters = self.rideParameters, let destination = rideParameters.destination
        {
            self.delegate?.requestController(self, didSelectDestination: destination)
        }
    }

    /**

    */
    @IBAction private func handlePaymentMethodButtonTap(sender: UIButton) -> Void
    {
        let oldSelection = sender.superview?.subviews.filter({ $0 is UIButton && $0.backgroundColor == Theme.current.tintColor }).first as? UIButton

        if sender === self.buttonPayApplePay
        {
            self.rideParameters?.paymentMethod = .applePay
        }
        else if sender === self.buttonPayPayPal
        {
            self.rideParameters?.paymentMethod = .paypal
        }
        else
        {
            self.rideParameters?.paymentMethod = .visa
        }

        self.transition(to: sender, from: oldSelection)
    }

    /**

    */
    @IBAction private func handleCarMethodButtonTap(sender: UIButton) -> Void
    {
        let oldSelection = sender.superview?.subviews.filter({ $0 is UIButton && $0.backgroundColor == Theme.current.tintColor }).first as? UIButton
        
        if sender === self.buttonCarElectric
        {
            self.rideParameters?.carType = .electric
        }
        else if sender === self.buttonCarExecutive
        {
            self.rideParameters?.carType = .executive
        }
        else
        {
            self.rideParameters?.carType = .group
        }

        self.transition(to: sender, from: oldSelection)
    }

    /**

    */
    @IBAction private func handleRequestRideButton(sender: UIButton) -> Void
    {
        guard let rideParameters = self.rideParameters else
        {
            return
        }
        
        // Ya tenemos los parametros para un recorrido
        self.delegate?.requestController(self, didFinishRequestRide: rideParameters)
    }
}
