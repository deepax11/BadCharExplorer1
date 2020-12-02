//
//  BadCharacterListVC.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 11/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import UIKit
import NetworkKit
import DTOKit

struct BadCharacterListViewState {
    let items: [BadCharacterCellViewState]
}

class BadCharacterListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static func makeVC(with viewModel: BadCharListViewModel) -> BadCharacterListVC {
        let vc = BadCharacterListVC.initFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: BadCharListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configViews()
        self.configDataBinding()
        self.configErrorBinding()
        self.viewModel.fetchSearchedResult()
    }
    
    func configViews() {
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    //MARK: Bindings
    
    private func configDataBinding() {
        self.viewModel.data.bind() { [weak self] data in
            guard let strongSelf = self  else { return }

            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }


    private func configErrorBinding() {
        self.viewModel.error.bind() { error in
            //TODO: handle error
        }
    }

    //MARK: UITableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.value.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BadCharacterCellView.reuseIdentifier, for: indexPath) as! BadCharacterCellView
        
        let viewState = viewModel.data.value.items[indexPath.row]
        cell.config(state: viewState)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.showDetail(at: indexPath.row)
    }
    
    
}

