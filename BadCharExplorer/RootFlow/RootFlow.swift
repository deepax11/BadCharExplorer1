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
        let resource = BadCharacterListingResource()
        let request = APIRequest(endpoint: resource, environment: apiEnvironment)
        
        let viewModel = BreakingBadCharListVM(apiRequest: request)
        viewModel.detailClosure = { [weak self] badCharacter in
            self?.showCharacterDetailView(for: badCharacter)
        }
        
        let vc = BreakingBadCharListVC.makeVC(with: viewModel)
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func showCharacterDetailView(for character: BreakingBadCharacter) {
        let viewModel = BreakingBadCharDetailVM(character: character)
        let vc = BreakingBadCharDetailVC.makeVC(with: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
