//
//  SelectionVC.swift
//  BadCharExplorer
//
//  Created by Deepak Shukla on 05/12/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionListVCDelegate : class {
    func selectionListVC(_ tableView: SelectionListVC, didSelectItemAtIndex index: IndexPath)
}


class SelectionListCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    
    func config(item: String) {
        self.addressLabel.text = item
    }
}


class SelectionListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SelectionListVCDelegate?

    var dataList: [String] = []

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Please select"
    }

    //MARK: UITableViewDataSource
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionListCell", for: indexPath) as! SelectionListCell
        cell.addressLabel.text = dataList[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectionListVC(self, didSelectItemAtIndex: indexPath)
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
