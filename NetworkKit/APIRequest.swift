//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case invalidURL
}

public class APIRequest<Endpoint: APIEndpoint> {
    let endpoint: Endpoint
    let environment: APIEnvironmentProtocol
        
    public init(endpoint: Endpoint, environment: APIEnvironmentProtocol) {
        self.endpoint = endpoint
        self.environment = environment
    }
}

extension APIRequest {
    // TODO: Implement JSON decode error handling
    // TODO: Log any JSON decode error to know about any missing mandatory field
    
    public func decode(_ data: Data?) -> Endpoint.ModelType? {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(endpoint.dateFormatter)
        do {
            let data = try decoder.decode(Endpoint.ModelType.self, from: data)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    @discardableResult
    public func request(withCompletion completion: @escaping (Endpoint.ModelType?, Error?) -> Void) -> URLRequest? {
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
        
        actualRequest(request, withCompletion: completion)
        
        return request
    }
    
    // TODO: Implement API Error handling
    
    private func actualRequest(_ urlRequest: URLRequest, withCompletion completion: @escaping (Endpoint.ModelType?, Error?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let strongSelf = self else {
                return
            }
            
            completion(strongSelf.decode(data), error)
        })
        
        task.resume()
    }
}
