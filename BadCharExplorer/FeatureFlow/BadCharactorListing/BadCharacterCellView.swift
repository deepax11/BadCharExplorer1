//
//  BadCharacterCellView.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

struct BadCharacterCellViewState {
    let imageURL: String
    let name: String
}

class BadCharacterCellView: UITableViewCell {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
        
    func config(state: BadCharacterCellViewState) {
        // TODO: Implement imageview extenstion where it loads imahe from URL asynchronously
        self.imageView?.image = nil
        self.nameLabel.text = state.name
    }
    
}
