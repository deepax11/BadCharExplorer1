//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation


public class APIRequest<Resource: APIResource> {
    
    // TODO: This should move to APIResource where each request can have their own decoding strategy
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return formatter
    }

    let resource: Resource
    let environment: APIEnvironmentProtocol
    
    public init(resource: Resource, environment: APIEnvironmentProtocol) {
        self.resource = resource
        self.environment = environment
    }
}

extension APIRequest: APIClient {
    public func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let data = try? decoder.decode(Resource.ModelType.self, from: data)
        return data
    }
    
    public func load(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
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
        
        load(request, withCompletion: completion)
    }
}
