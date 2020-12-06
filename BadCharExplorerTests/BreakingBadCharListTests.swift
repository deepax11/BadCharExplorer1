//
//  BadCharExplorerTests.swift
//  BadCharExplorerTests
//
//  Created by Deepak Shukla on 29/11/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import XCTest
@testable import BadCharExplorer
import NetworkKit
import DTOKit

class BadCharExplorerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testThatVMNotifiesofCorrectListOfCharacters() throws {
        let apiEndpoint = BadCharactersAPIEndpoint()
        let apiRequest = MockBreakingBadCharRequest()
        let viewModel = BreakingBadCharListVM(apiRequest: apiRequest, endpoint: apiEndpoint)
        
        // input
        
        let expectation = self.expectation(description: "Check viewModel triggers data binding with right list of characters")
        
        viewModel.data.bind() { data in
            XCTAssert(data.count == 63 , "Character list is empty against Mock JSON which are having 63 characters.")
            expectation.fulfill()
        }
        
        // Execute
        viewModel.fetchResults()
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
        }
        
    }
    
    func testThatVMNotifiesOfCorrectFilteredListOfCharactersWhenSearched() throws {
        let apiEndpoint = BadCharactersAPIEndpoint()
        let apiRequest = MockBreakingBadCharRequest()
        let viewModel = BreakingBadCharListVM(apiRequest: apiRequest, endpoint: apiEndpoint)
        
        // input
        let expectation = self.expectation(description: "Check viewModel notifies filtered list of characters")
        viewModel.fetchResults()
        viewModel.data.bind() { data in
            XCTAssert(data.first?.name == "Ken" , "Character Named Ken is missing")
            expectation.fulfill()
        }
        
        // Execute - Added delay so that fetchResults
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            viewModel.fetchResults(withSearchTerm: "Ken")
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
        }
        
    }
    
    
    func testThatVMNotifiesOfCorrectFilteredListOfCharactersWhenSeasonSelected() throws {
        let apiEndpoint = BadCharactersAPIEndpoint()
        let apiRequest = MockBreakingBadCharRequest()
        let viewModel = BreakingBadCharListVM(apiRequest: apiRequest, endpoint: apiEndpoint)
        
        // input
        let expectation = self.expectation(description: "Check viewModel notifies filtered list of characters")
        viewModel.fetchResults()
        viewModel.data.bind() { charList in
            for eachChar in charList {
                let charDetail = viewModel.fetchCharacterDetail(of: eachChar.id)
                let apearences = charDetail?.appearances ?? []
                XCTAssert(apearences.contains(Season.season1) , "filtered list has character which does not belong to season 1")
            }
            expectation.fulfill()
        }
        
        // Execute - Added delay so that fetchResults
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            viewModel.fetchResults(forSeasonNumber: 1)
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
        }
        
    }

}


class MockBreakingBadCharRequest: APIRequestProtocol {
    func request<T>(endpoint: T, completion: @escaping (T.ModelType?, Error?) -> Void) -> URLRequest? where T : APIEndpoint {
        
        let json = MockJSON.json("BreakingBadCharList")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(endpoint.dateFormatter)
        do {
            let data = try decoder.decode(T.ModelType.self, from: json)
            completion(data, nil)
            
        } catch {
            completion(nil, nil)
        }
        
        return nil
    }
    
}
