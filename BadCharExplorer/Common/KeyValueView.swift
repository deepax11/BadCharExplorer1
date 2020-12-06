//
//  KeyValueView.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 04/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

struct KeyValueViewState {
    var key: String
    var value: String
}

final class KeyValueView: UIView {
    
    // MARK: Properties
    private var contentView: UIStackView!
    private var keyLabel = UILabel()
    private var valueLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        contentView.axis = .horizontal
        contentView.alignment = .top
        contentView.distribution = .fill
        contentView.spacing = 8
        addWithinBounds(contentView)
        
        keyLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        valueLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
    }
    
    // MARK: Render
    
    func render(with state: KeyValueViewState) {
        keyLabel.text = state.key
        valueLabel.text = state.value
    }
}
