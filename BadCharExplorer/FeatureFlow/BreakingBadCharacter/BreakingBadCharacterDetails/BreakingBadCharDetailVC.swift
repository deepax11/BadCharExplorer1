//
//  BadCharacterDetailVC.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 02/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import UIKit


class BreakingBadCharDetailVC: UIViewController {
    
    static func makeVC(with viewModel: BreakingBadCharDetailVM) -> BreakingBadCharDetailVC {
        let vc = BreakingBadCharDetailVC.initFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
    
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var infoStackView: UIStackView!
    
    var viewModel: BreakingBadCharDetailVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataBinding()
        self.viewModel.fetchViewState()
    }
    
    
    private func configDataBinding() {
        viewModel.data.bind { [weak self] viewState in
            self?.render(viewState)
        }
    }
    
    
    private func render(_ state: BreakingBadCharDetailViewState?) {
        guard let state = state else { return }
        
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.loadWithURL(state.heroImageURL)
        
        state.values.forEach { state in
            let keyValueView = KeyValueView()
            keyValueView.render(with: state)
            infoStackView.addArrangedSubview(keyValueView)
        }
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        infoStackView.addArrangedSubview(spacer)
        
    }
    
}
