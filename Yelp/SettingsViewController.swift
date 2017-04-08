//
//  SettingsViewController.swift
//  Yelp
//
//  Created by bis on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func filtersChanged(sender: SettingsViewController, filters: [String: Bool])
}


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategorySwichDelegate {

    @IBOutlet weak var filterTableView: UITableView!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        categories = yelpCategories()
        switchStateByCategory = [:]
    }

    var categories: [[String: String]]!
    var switchStateByCategory: [String: Bool] = [:]
    
    func yelpCategories() -> [[String: String]] {
        return [
            ["name": "Afgan", "code": "afgani"],
            ["name": "Argentine", "code": "argentine"],
            ["name": "Asian Fusion", "code": "asianfusion"],
        ]
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterTableView.dequeueReusableCell(withIdentifier: "CategorySwitchCell",
                                                       for: indexPath) as! CategorySwitchCell
        cell.delegate = self
        let category = categories[indexPath.row]
        cell.nameLabel.text = category["name"]
        cell.categorySwitch.isOn = switchStateByCategory[category["code"]!] ?? false
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.filtersChanged(sender: self, filters: self.switchStateByCategory)
    }
    
    func categorySwitchvalueChanged(sender: CategorySwitchCell, value: Bool) {
        let rowNum = filterTableView.indexPath(for: sender)!.row
        let category = categories[rowNum]
        switchStateByCategory[category["code"]!] = value
    }
}
