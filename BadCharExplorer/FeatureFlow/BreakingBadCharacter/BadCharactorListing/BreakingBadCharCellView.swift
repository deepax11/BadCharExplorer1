//
//  BadCharacterCellView.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit
import NetworkKit

struct BreakingBadCharCellViewState {
    let id: Int
    let imageURL: String
    let name: String
}

class BreakingBadCharCellView: UITableViewCell {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel = BreakingBadCharCellViewVM()
    var state: BreakingBadCharCellViewState?
    
    func config(state: BreakingBadCharCellViewState) {
        self.state = state
        self.nameLabel.text = state.name
        
        self.logoView.image = nil
        self.viewModel.loadImage(from: state.imageURL) { [weak self] image, responseUrl in
            if let currentURL = self?.state?.imageURL.asURL, let url = responseUrl,
                currentURL == url {
                self?.logoView.image = image
            }
        }
    }
    
}
