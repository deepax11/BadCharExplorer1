//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation


public class APIRequest<Resource: APIEndpoint> {
    let resource: Resource
    let environment: APIEnvironmentProtocol
    
    public init(resource: Resource, environment: APIEnvironmentProtocol) {
        self.resource = resource
        self.environment = environment
    }
}

extension APIRequest {
    // TODO: Implement JSON decode error handling
    // TODO: Log any JSON decode error to know about any missing mandatory field
    
    public func decode(_ data: Data?) -> Resource.ModelType? {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(resource.dateFormatter)
        do {
            let data = try decoder.decode(Resource.ModelType.self, from: data)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    
    public func request(withCompletion completion: @escaping (Resource.ModelType?, Error?) -> Void) {
        let baseURL = environment.baseUrl
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return
            //TODO: Throw invalid URL exception
        }
        components.path = resource.path
        components.queryItems = resource.queryItems
        
        guard let url = components.url else {
            //TODO: Throw invalid URL exception
            return
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: resource.cachePolicy,
                                 timeoutInterval: resource.timeoutInterval)
        
        request.httpMethod = resource.method.rawValue
        request.httpBody = resource.body
        
        resource.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        actualRequeest(request, withCompletion: completion)
    }
    
    // TODO: Implement API Error handling
    
    private func actualRequeest(_ urlRequest: URLRequest, withCompletion completion: @escaping (Resource.ModelType?, Error?) -> Void) {
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
