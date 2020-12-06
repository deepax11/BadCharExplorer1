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


protocol BreakingBadCharListVMProtocol {
    init(apiRequest: APIRequestProtocol, endpoint: BadCharactersAPIEndpoint)
    func fetchResults()
    func fetchResults(withSearchTerm searchTerm: String?)
    func fetchResults(forSeasonNumber seasonNumber: Int)
}


class BreakingBadCharListVM: BreakingBadCharListVMProtocol {
    
    let apiRequest: APIRequestProtocol
    let apiEndpoint: BadCharactersAPIEndpoint
    
    required init(apiRequest: APIRequestProtocol, endpoint: BadCharactersAPIEndpoint) {
        self.apiRequest = apiRequest
        self.apiEndpoint = endpoint
    }
    
    private(set) var data: DynamicValue<BadCharacterListViewState> = DynamicValue([])
    private(set) var error: DynamicValue<Error?> = DynamicValue(nil)
    private(set) var selectedSeason: DynamicValue<Season> = DynamicValue(Season.none)
    
    private var badCharacters : [BreakingBadCharacter] = []
    var detailClosure: ((BreakingBadCharacter) -> Void)?
    
    
    func fetchResults() {
        apiRequest.request(endpoint: apiEndpoint) { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                strongSelf.error.value = error
            } else {
                strongSelf.badCharacters = result ?? []
                let viewStates = strongSelf.mapCharactersToViewState(characters: strongSelf.badCharacters,
                                                                     for: .none)
                strongSelf.data.value = viewStates
            }
            
        }
    }
    
    
    private func mapCharactersToViewState(characters: [BreakingBadCharacter], for season: Season) -> BadCharacterListViewState {
        var filteredChars = characters
        if season != .none {
            filteredChars = filteredChars.filter { badCharacter in
                let appearances = badCharacter.appearances ?? []
                return appearances.contains(season)
            }
        }
        
        let listViewState = filteredChars.map {
            BreakingBadCharCellViewState(id: $0.id, imageURL: $0.imageUrl, name: $0.name)
        }.sorted {
            $0.name < $1.name
        }
        
        return listViewState
    }
    
    func fetchResults(withSearchTerm searchTerm: String?) {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            let selectedSeason = self.selectedSeason.value
            self.data.value = mapCharactersToViewState(characters: badCharacters, for: selectedSeason)
            return
        }
        
        let selectedSeason = self.selectedSeason.value
        let filteredChars = badCharacters.filter { $0.name.contains(searchTerm)}
        let viewStates = mapCharactersToViewState(characters: filteredChars, for: selectedSeason)
        self.data.value = viewStates
    }
    
    func fetchResults(forSeasonNumber seasonNumber: Int) {
        guard let requestedSeason = Season(rawValue: seasonNumber) else {
            return // Not a valid season
        }
        
        if selectedSeason.value == requestedSeason {
            return // Same season has been selected, No need to process further
        }
        
        self.data.value = mapCharactersToViewState(characters: badCharacters, for: requestedSeason)
        self.selectedSeason.value = requestedSeason
    }
    
    
    func selectedSeasonInformation(season: Season) -> String {
        let seasonInfo = "Filtered by Season: \(season.displayName)"
        return seasonInfo
    }
    
    // Detail action
    
    func fetchCharacterDetail(of characterID: Int) -> BreakingBadCharacter? {
        //TODO: If list is large, data should be stored sqlite database and then fetched from there
        //TODO: if list is small keep data in memory in dictionary format for quick lookup
        guard let character = self.badCharacters.first (where: { $0.id == characterID }) else {
            return nil
        }
        return character
    }
    
    func showCharacterDetail(of characterID: Int) {
        if let character = fetchCharacterDetail(of: characterID){
            detailClosure?(character)
        }
    }
    
}

