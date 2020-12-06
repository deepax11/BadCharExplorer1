//
//  Common.swift
//  BadCharExplorerTests
//
//  Created by Deepak Shukla on 06/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

class MockJSON {
    static func json(_ file: String) -> Data {
        let bundle = Bundle(for: MockJSON.self)
        let url = bundle.url(forResource: file, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
}
