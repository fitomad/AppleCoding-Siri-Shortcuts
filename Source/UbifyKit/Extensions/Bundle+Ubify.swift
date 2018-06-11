//
//  Bundle+Ubify.swift
//  UbifyKit
//
//  Created by Adolfo Vera Blasco on 8/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

extension Bundle
{
    internal static var ubifyBundle: Bundle
    {
        return Bundle(for: BookRideIntentHandler.self)
    }
}
