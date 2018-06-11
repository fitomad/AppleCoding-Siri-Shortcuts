//
//  Driver.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 9/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import UIKit
import Foundation

public struct Driver: Codable
{
    // Driver's name
    public private(set) var name: String
    /// Fake URL. It's only resource name ;-)
    public private(set) var imageURL: String
}

extension Driver
{
    ///
    public var image: UIImage?
    {
        return UIImage(named: self.imageURL)
    }
}
