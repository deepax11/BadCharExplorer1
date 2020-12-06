//
//  Seasons.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 05/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import DTOKit

extension Season {
    var displayName: String {
        switch self {
        case .none:
            return "None"
        default:
            return "Season \(self.rawValue)"
        }
    }
}
