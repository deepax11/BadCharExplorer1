//
//  BreakingBadCharCellViewVM.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 14/04/2021.
//  Copyright © 2021 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit
import NetworkKit

struct BreakingBadCharCellViewVM {
    private var imageRequest = ImageRequest()
    
    mutating func loadImage(from urlConvertible: CustomURLConvertible,
                            completion: @escaping ((UIImage?, URL?) -> Void)) {
        guard let url = urlConvertible.asURL else {
            completion(nil, nil)
            return
        }
        
        imageRequest.request(URLRequest(url: url)) { image in
            completion(image, url)
        }
        
    }
}
