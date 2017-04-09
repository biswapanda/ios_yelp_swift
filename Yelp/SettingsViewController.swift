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
            ["name": "Afghan", "code": "afghani"],
            ["name": "African", "code": "african"],
            ["name": "Arabian", "code": "arabian"],
            ["name": "Argentine", "code": "argentine"],
            ["name": "Armenian", "code": "armenian"],
            ["name": "Asian Fusion", "code": "asianfusion"],
            ["name": "Australian", "code": "australian"],
            ["name": "Austrian", "code": "austrian"],
            ["name": "Bangladeshi", "code": "bangladeshi"],
            ["name": "Basque", "code": "basque"],
            ["name": "Barbeque", "code": "bbq"],
            ["name": "Belgian", "code": "belgian"],
            ["name": "Brasseries", "code": "brasseries"],
            ["name": "Brazilian", "code": "brazilian"],
            ["name": "Breakfast & Brunch", "code": "breakfast_brunch"],
            ["name": "British", "code": "british"],
            ["name": "Buffets", "code": "buffets"],
            ["name": "Burgers", "code": "burgers"],
            ["name": "Burmese", "code": "burmese"],
            ["name": "Cafes", "code": "cafes"],
            ["name": "Cafeteria", "code": "cafeteria"],
            ["name": "Cajun/Creole", "code": "cajun"],
            ["name": "Cambodian", "code": "cambodian"],
            ["name": "Caribbean", "code": "caribbean"],
            ["name": "Catalan", "code": "catalan"],
            ["name": "Cheesesteaks", "code": "cheesesteaks"],
            ["name": "Chicken Wings", "code": "chicken_wings"],
            ["name": "Chicken Shop", "code": "chickenshop"],
            ["name": "Chinese", "code": "chinese"],
            ["name": "Comfort Food", "code": "comfortfood"],
            ["name": "Creperies", "code": "creperies"],
            ["name": "Cuban", "code": "cuban"],
            ["name": "Czech", "code": "czech"],
            ["name": "Delis", "code": "delis"],
            ["name": "Diners", "code": "diners"],
            ["name": "Dinner Theater", "code": "dinnertheater"],
            ["name": "Ethiopian", "code": "ethiopian"],
            ["name": "Filipino", "code": "filipino"],
            ["name": "Fish & Chips", "code": "fishnchips"],
            ["name": "Fondue", "code": "fondue"],
            ["name": "Food Court", "code": "food_court"],
            ["name": "Food Stands", "code": "foodstands"],
            ["name": "French", "code": "french"],
            ["name": "Gastropubs", "code": "gastropubs"],
            ["name": "German", "code": "german"],
            ["name": "Gluten-Free", "code": "gluten_free"],
            ["name": "Greek", "code": "greek"],
            ["name": "Guamanian", "code": "guamanian"],
            ["name": "Halal", "code": "halal"],
            ["name": "Hawaiian", "code": "hawaiian"],
            ["name": "Himalayan/Nepalese", "code": "himalayan"],
            ["name": "Hong Kong Style Cafe", "code": "hkcafe"],
            ["name": "Honduran", "code": "honduran"],
            ["name": "Hot Dogs", "code": "hotdog"],
            ["name": "Fast Food", "code": "hotdogs"],
            ["name": "Hot Pot", "code": "hotpot"],
            ["name": "Hungarian", "code": "hungarian"],
            ["name": "Iberian", "code": "iberian"],
            ["name": "Indonesian", "code": "indonesian"],
            ["name": "Indian", "code": "indpak"],
            ["name": "Irish", "code": "irish"],
            ["name": "Italian", "code": "italian"],
            ["name": "Japanese", "code": "japanese"],
            ["name": "Kebab", "code": "kebab"],
            ["name": "Korean", "code": "korean"],
            ["name": "Kosher", "code": "kosher"],
            ["name": "Laotian", "code": "laotian"],
            ["name": "Latin American", "code": "latin"],
            ["name": "Malaysian", "code": "malaysian"],
            ["name": "Mediterranean", "code": "mediterranean"],
            ["name": "Mexican", "code": "mexican"],
            ["name": "Middle Eastern", "code": "mideastern"],
            ["name": "Modern European", "code": "modern_european"],
            ["name": "Mongolian", "code": "mongolian"],
            ["name": "Moroccan", "code": "moroccan"],
            ["name": "American (New)", "code": "newamerican"],
            ["name": "New Mexican Cuisine", "code": "newmexican"],
            ["name": "Nicaraguan", "code": "nicaraguan"],
            ["name": "Noodles", "code": "noodles"],
            ["name": "Pakistani", "code": "pakistani"],
            ["name": "Pan Asian", "code": "panasian"],
            ["name": "Persian/Iranian", "code": "persian"],
            ["name": "Peruvian", "code": "peruvian"],
            ["name": "Pizza", "code": "pizza"],
            ["name": "Polish", "code": "polish"],
            ["name": "Pop-Up Restaurants", "code": "popuprestaurants"],
            ["name": "Portuguese", "code": "portuguese"],
            ["name": "Poutineries", "code": "poutineries"],
            ["name": "Live/Raw Food", "code": "raw_food"],
            ["name": "Russian", "code": "russian"],
            ["name": "Salad", "code": "salad"],
            ["name": "Sandwiches", "code": "sandwiches"],
            ["name": "Scandinavian", "code": "scandinavian"],
            ["name": "Scottish", "code": "scottish"],
            ["name": "Seafood", "code": "seafood"],
            ["name": "Singaporean", "code": "singaporean"],
            ["name": "Slovakian", "code": "slovakian"],
            ["name": "Soul Food", "code": "soulfood"],
            ["name": "Soup", "code": "soup"],
            ["name": "Southern", "code": "southern"],
            ["name": "Spanish", "code": "spanish"],
            ["name": "Sri Lankan", "code": "srilankan"],
            ["name": "Steakhouses", "code": "steak"],
            ["name": "Supper Clubs", "code": "supperclubs"],
            ["name": "Sushi Bars", "code": "sushi"],
            ["name": "Syrian", "code": "syrian"],
            ["name": "Taiwanese", "code": "taiwanese"],
            ["name": "Tapas Bars", "code": "tapas"],
            ["name": "Tapas/Small Plates", "code": "tapasmallplates"],
            ["name": "Tex-Mex", "code": "tex-mex"],
            ["name": "Thai", "code": "thai"],
            ["name": "American (Traditional)", "code": "tradamerican"],
            ["name": "Turkish", "code": "turkish"],
            ["name": "Ukrainian", "code": "ukrainian"],
            ["name": "Uzbek", "code": "uzbek"],
            ["name": "Vegan", "code": "vegan"],
            ["name": "Vegetarian", "code": "vegetarian"],
            ["name": "Vietnamese", "code": "vietnamese"],
            ["name": "Waffles", "code": "waffles"],
            ["name": "Wraps", "code": "wraps"],
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