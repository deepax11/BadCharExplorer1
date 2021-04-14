//
//  MockedResourceObject.swift
//  DTOKitTests
//
//  Created by Deepak Shukla on 01/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
@testable import NetworkKit

// Define your environment

public enum TestEnvironment : APIEnvironmentProtocol {
    case test
    public var baseUrl: URL {
         return URL(string: "https://gist.githubusercontent.com/")!
    }

}

// Define your Model (DTO)
public struct ProductListing: Decodable {
    let products: [Product]
}

public struct Product: Decodable {
    let title: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
    }
}

// Define your request's resource
public struct ProductListingEndpoint: APIEndpoint {
    public typealias ModelType = ProductListing
    
    public init() { }

    public var path: String {
        "/deepax11/61d14c8dc578bb40acbdc9d2b585c1c9/raw/2dadbdb57960e57c94787f54e6bcec75cec5acc9/productlist"
    }
    
    public var scope: String {
        return ""
    }
    
}

