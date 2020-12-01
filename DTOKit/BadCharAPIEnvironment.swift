//
//  APIEnvironment.swift
//  DTOKit
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import NetworkKit

public enum APIEnvironment : APIEnvironmentProtocol {
    case dev
    
    public var baseUrl: URL {
         return URL(string: "https://breakingbadapi.com")!
    }

}
