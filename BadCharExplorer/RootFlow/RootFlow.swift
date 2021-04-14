//
//  RootFlow.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 01/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import UIKit
import DTOKit
import NetworkKit

class RootFlow: Flow {
    
    var children = [Flow]()
    var navigationController: UINavigationController
    let apiEnvironment: APIEnvironment

    init(navigationController: UINavigationController, environment: APIEnvironment) {
        self.navigationController = navigationController
        self.apiEnvironment = environment
    }

    func start() {
        
        // Injectable and mockable network input
        let endpoint = BadCharactersAPIEndpoint()
        let request = APIRequest(environment: apiEnvironment)
        
        // Business layer + presentation layer (for big projects it should be devided in its respective layers)
        let viewModel = BreakingBadCharListVM(apiRequest: request, endpoint: endpoint)
        viewModel.detailClosure = { [weak self] badCharacter in
            self?.showCharacterDetailView(for: badCharacter)
        }
        
        // UILayer
        let vc = BreakingBadCharListVC.makeVC(with: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func showCharacterDetailView(for character: BreakingBadCharacter) {
        let viewModel = BreakingBadCharDetailVM(character: character)
        let vc = BreakingBadCharDetailVC.makeVC(with: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
