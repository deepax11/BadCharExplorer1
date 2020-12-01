//
//  APIResource.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

public protocol APIEndpoint {
    associatedtype ModelType: Decodable
    
    var path: String { get }
    var scope: String { get }
    var method: APIMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }
    var authenticated: Bool { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var dateFormatter: DateFormatter { get }
}

public extension APIEndpoint {
    var method: APIMethod {
        return .get
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json; charset=utf8"]
    }
    
    var body: Data? {
        return nil
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }

    var authenticated: Bool {
        return true // if true handle token
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
    
    var timeoutInterval: TimeInterval {
        return 60.0
    }
    
    var dateFormatter : DateFormatter {
        return DateFormatter()
    }
    

}
