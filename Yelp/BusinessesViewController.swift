//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsViewControllerDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    let searchBar = UISearchBar()
    
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Restaurants"
        businessTableView.delegate = self
        businessTableView.dataSource = self
        businessTableView.rowHeight = UITableViewAutomaticDimension
        businessTableView.estimatedRowHeight = 150
        Business.searchWithTerm(term: "Thai",
                                completion: { (businesses: [Business]?, error: Error?) -> Void in
                                    self.businesses = businesses
                                    self.businessTableView.reloadData()
        }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = businessTableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell",
                                                         for: indexPath) as! BusinessTableViewCell
        cell.business = self.filteredBusinesses()![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredBusinesses()?.count ?? 0
    }

    func filtersChanged(sender: SettingsViewController, filters: [String : Bool]) {
        var categories: [String] = []
        for (k, v) in filters {
            if v {
                categories.append(k)
            }
        }
        Business.searchWithTerm(term: "Restaurants",
                                sort: .distance,
                                categories: categories,
                                deals: true)
        { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.businessTableView.reloadData()
        }
    }
    
    func filteredBusinesses() -> [Business]? {
        let searchText = searchBar.text
        if searchText == nil || searchText == "" {
            return businesses
        }
        else {
            var matchingBusinesses: [Business] = []
            for b in businesses {
                if b.name!.lowercased().range(of: searchText!.lowercased()) != nil {
                    matchingBusinesses.append(b)
                }
            }
            return matchingBusinesses
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let settingsController = navController.topViewController as! SettingsViewController
        settingsController.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        businessTableView.reloadData()
    }
}
