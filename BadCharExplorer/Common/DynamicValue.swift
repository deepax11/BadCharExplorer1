//
//  DynamicValue.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation


import Foundation
// http://rasic.info/bindings-generics-swift-and-mvvm/

import Foundation

public class DynamicValue<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    
    public func bind(listener: Listener?) {
        self.listener = listener
    }
    
    public func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ initialValue: T) {
        value = initialValue
    }
}
