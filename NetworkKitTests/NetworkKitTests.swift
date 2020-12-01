//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Deepak Shukla on 29/11/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import XCTest
@testable import NetworkKit

class NetworkKitTests: XCTestCase {

   //TODO: Write various test cases with variation of predefind APIEndpoint
    // Make sure valid request object gets created
    // Adding one here for example

    func testThatProperGetRequestCreatedFromAPIEndpoint() throws {
        let request = APIRequest(endpoint: MockedEndpoint(), environment: TestEnvironment.test)
        let urlRequest = request.request { data, error in }
        
        XCTAssert(urlRequest?.httpBody == nil, "Get request should not have body")
        XCTAssert(urlRequest?.httpMethod == "GET", "Get request should have its method type `GET`")
        XCTAssert(urlRequest?.url?.path == "/path1/path2", "Get request path is not matching")
    }
    

}


public enum TestEnvironment : APIEnvironmentProtocol {
    case test
    
    public var baseUrl: URL {
        return URL(string: "https://gist.githubusercontent.com/")!
    }
}


// Define your request's resource
public struct MockedEndpoint: APIEndpoint {
    
    public typealias ModelType = String
    
    public init() { }

    public var method: APIMethod {
        return .get
    }
    
    public var path: String {
        "/path1/path2"
    }
    
    public var scope: String {
        return ""
    }
    
}
