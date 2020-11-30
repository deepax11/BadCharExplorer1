//
//  APIService.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

protocol APIClient: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension APIClient {
     func load(_ urlRequest: URLRequest, withCompletion completion: @escaping (ModelType?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let strongSelf = self else {
                return
            }
            
            // TODO: Implement Error handling
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(strongSelf.decode(data))
        })
        task.resume()
    }
}
