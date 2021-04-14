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

typealias BadCharacterListViewState = [BreakingBadCharCellViewState]

class BreakingBadCharListVC: UIViewController {
    
    static func makeVC(with viewModel: BreakingBadCharListVM) -> BreakingBadCharListVC {
        let vc = BreakingBadCharListVC.initFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBySeasonButton: UIButton!
    
    var viewModel: BreakingBadCharListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configDataBinding()
        configErrorBinding()
        configSeasonStatusBinding()
        viewModel.fetchResults()
    }
    
    func configViews() {
        tableView.estimatedRowHeight = 100.0
        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self
        searchField.showsCancelButton = true
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
    
    private func configSeasonStatusBinding() {
        self.viewModel.selectedSeason.bindAndFire() { [weak self] value in
            guard let strongSelf = self else { return }
            let info = strongSelf.viewModel.selectedSeasonInformation(season: value)
            strongSelf.filterBySeasonButton.setTitle(info, for: .normal)
        }
    }
    
    
    // MARK:
    @IBAction func filterBySeasonButtonTapped(_ sender: Any) {
        resetSearchButton()
        // Hardcoding the season list. Could have iterated throught API's response and would have extracted all season but won't nice idea.
        // I would suggest to have seprate API to get list of seasons
        // OR
        // seprate configuration API which includes list of season and any other data which might be required for app to work effeciently
        let allSeasons = Season.allCases.map { $0.displayName }
        pushSelectionVC(options: allSeasons)
    }
    
    
    private func pushSelectionVC(options: [String]) {
        // As this VC is being used to select seasons to filter the list,
        // It does not need to go though flow controller
        // It is an intermediate list which would be dismissed after selection
        // Hance safe to avoid present via flow controller
        let vc = SelectionListVC.initFromStoryboard()
        vc.delegate = self
        vc.dataList = options
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func resetSearchButton() {
        searchField.text = ""
        searchField.resignFirstResponder()
    }
    
}


//MARK: UITableviewDelegate
extension BreakingBadCharListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resetSearchButton()
        tableView.deselectRow(at: indexPath, animated: true)
        let viewState = viewModel.data.value[indexPath.row]
        viewModel.showCharacterDetail(of: viewState.id)
    }
}

//MARK: UITableviewDelegate
extension BreakingBadCharListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreakingBadCharCellView.reuseIdentifier, for: indexPath) as! BreakingBadCharCellView
                
        let viewState = viewModel.data.value[indexPath.row]
        cell.config(state: viewState)
        
        return cell
    }
}


// MARK: UISearchBarDelegate
extension BreakingBadCharListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.fetchResults(withSearchTerm: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchResults(withSearchTerm: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearchButton()
        viewModel.fetchResults(withSearchTerm: searchBar.text)
    }
}


// MARK: SelectionListVCDelegate

extension BreakingBadCharListVC : SelectionListVCDelegate {
    func selectionListVC(_ tableView: SelectionListVC, didSelectItemAtIndex index: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        self.viewModel.fetchResults(forSeasonNumber: index.row)
    }

}
