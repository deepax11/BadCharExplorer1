//
//  BadCharacterDetailVM.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 02/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import DTOKit


struct BreakingBadCharDetailViewState {
    let heroImageURL: String
    let values: [KeyValueViewState]
}


struct BreakingBadCharDetailVM {
    
    var data: DynamicValue<BreakingBadCharDetailViewState?> = DynamicValue(nil)

    let breakingBadCharacter: BreakingBadCharacter
    
    init(character: BreakingBadCharacter) {
        self.breakingBadCharacter = character
    }
    
    func fetchViewState() {
        let imageURL = breakingBadCharacter.imageUrl
        let occupations = breakingBadCharacter.occupation.result.joined(separator: ", ")
        let seasons = breakingBadCharacter.appearances?
            .map ({ String($0.rawValue) })
            .joined(separator: ", ")
        
        let values = [
            KeyValueViewState(key: "Name:", value: breakingBadCharacter.name),
            KeyValueViewState(key: "Occupation:", value: occupations),
            KeyValueViewState(key: "Status:", value: breakingBadCharacter.status.rawValue),
            KeyValueViewState(key: "Nick Name:", value: breakingBadCharacter.nicName),
            KeyValueViewState(key: "Season:", value: seasons ?? "Unknown")
        ]
        
        self.data.value = BreakingBadCharDetailViewState(heroImageURL: imageURL, values: values)
    }
    
}
