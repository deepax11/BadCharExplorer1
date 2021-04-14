//
//  IteneraryResource.swift
//  DTOKit
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import NetworkKit

public struct BadCharactersAPIEndpoint: APIEndpoint {
    public typealias ModelType = OptionalArray<BreakingBadCharacter>
    
    public init() { }
    
    public var path: String {
        "/api/characters"
    }
    
    public var scope: String {
        return ""
    }
    
    public var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }
    
}
