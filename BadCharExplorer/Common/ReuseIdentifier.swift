//
//  ReuseIdentifier.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 01/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit


public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    public static var reuseIdentifier: String {
        return "\(self)"
    }
}


extension UICollectionViewCell: ReuseIdentifiable { }

extension UITableViewCell: ReuseIdentifiable { }
