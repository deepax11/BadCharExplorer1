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

class BadCharacterListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //TODO: use section header to show the price for each forward and return journey combo
    
    var viewModel = BadCharListViewModel() // TODO: Inject from flowController
    
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
        return self.viewModel.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BadCharacterCellView.reuseIdentifier, for: indexPath) as! BadCharacterCellView
        
        // fetch states from model and config
        return cell
    }
    
    
}

