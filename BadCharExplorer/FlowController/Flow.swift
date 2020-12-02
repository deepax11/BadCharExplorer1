//
//  FlowController.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 01/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import UIKit

protocol Flow {
    var children: [Flow] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
