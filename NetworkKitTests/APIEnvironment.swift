//
//  APIEnvironment.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

public protocol APIEnvironmentProtocol {
    var baseUrl: URL { get }
}

// Define your environment in below format

public enum APIEnvironment {
    case dev
}

extension APIEnvironment: APIEnvironmentProtocol {
    // Hardcode your domain or or override this implementation for base URL
    public var baseUrl: URL {
        switch self {
        case .dev:
            return URL(string: "https://gist.githubusercontent.com/")!
        }
    }
}

