//
//  UIViewExt.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 04/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addWithinBounds(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    func addWithinBounds(_ view: UIView, insets: UIEdgeInsets) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left),
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        ])
    }
}
