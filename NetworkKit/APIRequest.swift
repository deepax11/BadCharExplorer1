//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

private struct OptionalContainer<Base: Codable>: Codable {
    let base: Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        base = try? container.decode(Base.self)
    }
}

public struct OptionalArray<Base: Codable>: Codable {
    public let result: [Base]
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let tmp = try container.decode([OptionalContainer<Base>].self)
        result = tmp.compactMap { $0.base }
    }
}

public enum APIError: Error {
    case invalidURL
    case requestFailed
    case pasringFailure
    case invalidData

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "InvalidnURL"
        case .requestFailed: return "Request Failed"
        case .pasringFailure: return "Parsing failed"
        case .invalidData: return "Invalid Data"
        }
    }
}

public class APIRequest {
    let environment: APIEnvironmentProtocol
        
    public init(environment: APIEnvironmentProtocol) {
        self.environment = environment
    }
}

public protocol APIRequestProtocol {
    @discardableResult
    func request<T: APIEndpoint>(endpoint: T, completion: @escaping (T.ModelType?, Error?) -> Void) -> URLRequest?
}

extension APIRequest: APIRequestProtocol {
    
    @discardableResult
    public func request<T: APIEndpoint>(endpoint: T, completion: @escaping (T.ModelType?, Error?) -> Void) -> URLRequest? {
        let baseURL = environment.baseUrl
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            completion(nil, APIError.invalidURL)
            return nil
        }
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            completion(nil, APIError.invalidURL)
            return nil
        }
                
        var request = URLRequest(url: url,
                                 cachePolicy: endpoint.cachePolicy,
                                 timeoutInterval: endpoint.timeoutInterval)
        
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        endpoint.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        actualRequest(request) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, APIError.invalidData)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(endpoint.dateFormatter)
            do {
                let data = try decoder.decode(T.ModelType.self, from: data)
                completion(data, nil)
                
            } catch {
                completion(nil, APIError.pasringFailure)
            }
            
        }
        
        return request
    }
    
    // TODO: Implement API Error handling
    
    private func actualRequest(_ urlRequest: URLRequest, withCompletion completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            completion(data, error)
        })
        
        task.resume()
    }
}
