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


protocol BadCharListViewModelProtocol {
    init(apiRequest: APIRequest<BadCharactorListingResource>)
    func fetchSearchedResult()
}


class BadCharListViewModel: BadCharListViewModelProtocol {
        
    let apiRequest: APIRequest<BadCharactorListingResource>

    required init( apiRequest: APIRequest<BadCharactorListingResource>) {
        self.apiRequest = apiRequest
    }
    
    var data: DynamicValue<BadCharacterListViewState> = DynamicValue(BadCharacterListViewState(items: []))
    var error: DynamicValue<Error?> = DynamicValue (nil)
    var detailClosure: ((BadCharacter) -> Void)?
    private var badCaracters : [BadCharacter] = []
    
    func fetchSearchedResult() {
        apiRequest.request { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                strongSelf.error.value = error
                
            } else {
                strongSelf.badCaracters = result ?? []
                strongSelf.data.value = strongSelf.mapIteneraryDataToViewState(characters: strongSelf.badCaracters)
            }
            
        }
    }
    
    
    private func mapIteneraryDataToViewState(characters: [BadCharacter]) -> BadCharacterListViewState {
        let cellViewState = characters.map { BadCharacterCellViewState(imageURL: $0.imageUrl, name: $0.name) }
        let listViewState = BadCharacterListViewState(items: cellViewState)
        return listViewState
    }
    
    func showDetail(at index: Int) {
        let charracter = self.badCaracters[index]
        detailClosure?(charracter)
    }
    
}

