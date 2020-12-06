//
//  ImageRequest.swift
//  NetworkKit
//
//  Created by Deepak Shukla on 29/11/2020..
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

public class ImageRequest {
    public init () { }
}

public extension ImageRequest {
    func decode(_ data: Data?) -> UIImage? {
        guard let data = data else { return nil }
        return UIImage(data: data)
    }
    
    
    func request(_ urlRequest: URLRequest, withCompletion completion: @escaping (UIImage?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            let image = self?.decode(data)
            completion(image)
        })
        
        task.resume()
    }
}
