//
//  ResponseRideViewController.swift
//  AppleCoding Siri Shortcuts
//
//  Created by Adolfo Vera Blasco on 28/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import UIKit
import Foundation

import UbifyKit

internal class ResponseRideViewController: UIViewController
{
    ///
    @IBOutlet private weak var labelTitle: UILabel!
    ///
    @IBOutlet private weak var imageDriver: UIImageView!
    ///
    @IBOutlet private weak var labelDriverName: UILabel!
    ///
    @IBOutlet private weak var labelDriverAdvice: UILabel!

    ///
    @IBOutlet private weak var labelArrivalTime: UILabel!
    ///
    @IBOutlet private weak var labelArrivalAdvice: UILabel!

    ///
    @IBOutlet private weak var labelRideAmount: UILabel!
    ///
    @IBOutlet private weak var labelRideAmountAdvice: UILabel!

    ///
    @IBOutlet private weak var buttonCancelRide: UIButton!
    ///
    @IBOutlet private weak var buttonAddSiri: UIButton!
    
    ///
    internal weak var delegate: ResponseRideViewDelegate?
    
    ///
    internal var ride: Ride?
    {
        didSet
        {
            if let ride = self.ride
            {
                self.presentInformation(for: ride)
            }
        }
    }


    //
    // MARK: - Life Cycle
    //

    /**

    */
    override internal func viewDidLoad() -> Void
    {
        super.viewDidLoad()
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


        self.buttonCancelRide.backgroundColor = Theme.current.secondaryBackgroundColor
        self.buttonCancelRide.tintColor = Theme.current.textColor
        self.buttonCancelRide.layer.cornerRadius = 8.0
        self.buttonCancelRide.layer.masksToBounds = true
        
        self.buttonAddSiri.backgroundColor = Theme.current.tintColor
        self.buttonAddSiri.tintColor = Theme.current.backgroundColor
        self.buttonAddSiri.layer.cornerRadius = 8.0
        self.buttonAddSiri.layer.masksToBounds = true

        self.imageDriver.layer.cornerRadius = 8.0
        self.imageDriver.layer.masksToBounds = true
        
        self.labelArrivalTime.textColor = Theme.current.textColor
        self.labelDriverName.textColor = Theme.current.textColor
        self.labelRideAmount.textColor = Theme.current.textColor
        
        self.labelTitle.textColor = Theme.current.textColor
        
        self.labelArrivalAdvice.textColor = Theme.current.secondaryTextColor
        self.labelRideAmountAdvice.textColor = Theme.current.secondaryTextColor
        self.labelDriverAdvice.textColor = Theme.current.secondaryTextColor
    }
    
    /**

    */
    private func localizedText() -> Void
    {
        
    }
    
    private func presentInformation(for ride: Ride) -> Void
    {
        if let driver = ride.driver
        {
            self.labelDriverName.text = driver.name
            self.imageDriver.image = UIImage(named: driver.imageURL)
        }
        
        if let arrivalTime = ride.arrivalTime
        {
            self.labelArrivalTime.text = "\(arrivalTime) min"
        }
    }

    //
    // MARK: - Actions
    //

    /**
 
    */
    @IBAction private func handleAddToSiriTap(sender: UIButton) -> Void
    {
        guard let ride = self.ride, let identifier = ride.siriShortcutIdentifier else
        {
            return
        }
        
        self.delegate?.responseController(self, didRequestSiriVoiceForShortcut: identifier)
    }
    
    /**

    */
    @IBAction private func handleCancelRideButtonTap(sender: UIButton) -> Void
    {
        guard let ride = self.ride, let identifier = ride.siriShortcutIdentifier else
        {
            return
        }
        
        // Here is where we remove the Siri Shortcut
        self.delegate?.responseController(self, didCancelSiriDonation: identifier)

    }
}
