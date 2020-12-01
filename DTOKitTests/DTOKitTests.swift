//
//  DTOKitTests.swift
//  DTOKitTests
//
//  Created by Deepak Shukla on 30/11/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import XCTest
@testable import DTOKit
import NetworkKit

class DTOKitTests: XCTestCase {

    private var request: APIRequest<ProductListingEndpoint>!

    func testExample() throws {
        let expectation = self.expectation(description: "Check NetworkKit request")
        
        let resource = ProductListingEndpoint()
        request = APIRequest(endpoint: resource, environment: TestEnvironment.test)
        request.request { productList, error in
            XCTAssert(productList != nil ,  "Product response paylod is either missing or Invalid.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            self.handleError(error: error)
        }
    }
    
    func handleError(error: Error?) {
        if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
        }
    }

}

