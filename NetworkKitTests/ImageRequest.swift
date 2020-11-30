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
    let urlRequest: URLRequest
    
    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
    }
}

extension ImageRequest: APIClient {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(urlRequest, withCompletion: completion)
    }
}
