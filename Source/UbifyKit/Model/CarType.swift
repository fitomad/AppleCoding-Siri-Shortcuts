//
//  CarType.swift
//  UberfyKit
//
//  Created by Adolfo Vera Blasco on 6/6/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

public enum CarType: String, Codable
{
    case electric
    case executive
    case group
    
    ///
    public var localizedKey: String
    {
        switch self
        {
            case .electric:
                return "CAR_TYPE_ELECTRIC"
            case .executive:
                return "CAR_TYPE_EXECUTIVE"
            case .group:
                return "CAR_TYPE_GROUP"
        }
    }
    
    ///
    public var localizedString: String
    {
        return NSLocalizedString(self.localizedKey, bundle: Bundle.ubifyBundle, comment: "")
    }
}
