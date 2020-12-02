//
//  UIIMageViewExt.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 02/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit
    
// TODO: Use Image request defined in network kit
extension UIImageView {
    
    public func loadWithURL(_ url: CustomURLConvertible?) {
        guard let url = url?.asURL else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self?.image = image
                }
            }
        }).resume()
        
    }
    
}
