//
//  StoryboardLoadable.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 01/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardLoadable {
    static var storyboardName: String { get }
}


public extension StoryboardLoadable where Self: UIViewController {
    
    static var storyboardName: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(named: storyboardName)
        let viewController: Self = storyboard.makeInitialViewController()
        return viewController
    }
}


 extension UIViewController: StoryboardLoadable { }

public extension UIStoryboard {

    convenience init(named storyboardName: String, bundleNamed bundleName: String? = nil) {
        let bundle = bundleName.flatMap { Bundle(identifier: $0) }
        self.init(name: storyboardName, bundle: bundle)
    }

    func makeInitialViewController<T: UIViewController>() -> T {
        guard let controller = instantiateInitialViewController() as? T else {
            fatalError("Unable to create initial view controller.")
        }
        return controller
    }
}

