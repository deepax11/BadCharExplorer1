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
        let resource = BadCharactorListingResource()
        let request = APIRequest(endpoint: resource, environment: apiEnvironment)

        let viewModel = BadCharListViewModel(apiRequest: request)
        viewModel.detailClosure = { [weak self] badCharacter in
            self?.showCharacterDetailView(for: badCharacter)
        }
        
        let vc = BadCharacterListVC.makeVC(with: viewModel)
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCharacterDetailView(for character: BadCharacter) {
        //TODO:
        // 1 Create VM initialised with character
        // 2. Inject to VC in similar fashion as above
        // 3. Bind and fire tha data which immedietly triggers the rendering
        let vc = BadCharacterDetailVC.initFromStoryboard()
        navigationController.pushViewController(vc, animated: false)
    }
}
