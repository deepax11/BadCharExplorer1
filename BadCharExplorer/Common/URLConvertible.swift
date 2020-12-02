//
//  URLConvertible.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 02/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation

// protocol `URLConvertible` enables us to use have uniform interface 

public protocol CustomURLConvertible {
    var asURL: URL? { get }
}

extension String: CustomURLConvertible {
    public var asURL: URL? {
        return URL(string: self)
    }
}

extension URL: CustomURLConvertible {
    public var asURL: URL? {
        return self
    }
}
