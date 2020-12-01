//
//  BadCharListViewModel.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import DTOKit
import NetworkKit


struct BadCharacterListViewState {
    let items: [BadCharacterCellViewState]
    let price: String
    let agentName: String
}

class BadCharListViewModel {
    
    private var request: APIRequest<BadCharactorListingResource>?
    
    var data: DynamicValue<[BadCharacterListViewState]> = DynamicValue([BadCharacterListViewState]())
    var error: DynamicValue<Error?> = DynamicValue (nil)
    
    func fetchSearchedResult() {
        let resource = BadCharactorListingResource()
        request = APIRequest(resource: resource, environment: APIEnvironment.dev)
        request?.request { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                strongSelf.error.value = error

            } else {
                let characters = result ?? []
                strongSelf.data.value = strongSelf.mapIteneraryDataToViewState(characters: characters)
            }
            
        }
    }
    
    
    func mapIteneraryDataToViewState(characters: [BadCharacter]) -> [BadCharacterListViewState] {
        return [BadCharacterListViewState] ()
    }
    
}

