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

enum FilterType: Int {
    case Deal = 0
    case Distance = 1
    case SortBy = 2
    case Category = 3
}

class SettingsViewController: UIViewController, UITableViewDelegate,
    UITableViewDataSource, CategorySwichDelegate, MultiSelectTableViewCellDelegate {

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
    var isDeal: Bool = false
    let multiSelectDataSourceByFilterType = [
        FilterType.Distance: MultiSelectDataSource([("Auto", 0),
                                                 (".3 miles", 0.3),
                                                 ("1 miles", 1.0) ,
                                                 ("3 miles", 3.0) ,
                                                 ("5 mile", 20.0)]),
        FilterType.SortBy: MultiSelectDataSource([ ("Best Matched", 0),
                                                ("Distance", 1),
                                                ("Highest Rated", 2)])
    ]
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterType = FilterType.init(rawValue: indexPath.section)!
        switch filterType {
        case .Category:
            let cell = filterTableView.dequeueReusableCell(
                withIdentifier: "CategorySwitchCell", for: indexPath) as! CategorySwitchCell
            cell.delegate = self
            let category = categories[indexPath.row]
            cell.nameLabel.text = category["name"]
            cell.categorySwitch.isOn = switchStateByCategory[category["code"]!] ?? false
            return cell
        case .Deal:
            let cell = filterTableView.dequeueReusableCell(
                withIdentifier: "CategorySwitchCell", for: indexPath) as! CategorySwitchCell
            cell.delegate = self
            cell.nameLabel.text = "Offering A Deal"
            cell.categorySwitch.isOn = isDeal
            return cell
        case .SortBy:
            fallthrough
        case .Distance:
            let mds = multiSelectDataSourceByFilterType[filterType]!
            let distanceOption = mds.getNameForIndex(index: indexPath.row)
            let cell = filterTableView.dequeueReusableCell(withIdentifier:
                "MultiSelectTableViewCell", for: indexPath) as! MultiSelectTableViewCell
            cell.optionLabel.text = distanceOption
            var imageName: String!
            if mds.isExpanded {
                imageName = (indexPath.row == 0) ? "ok_green":  "ok_white"
            } else {
                imageName = "expand_arrow"
            }
            cell.selectStateButton.setImage(UIImage(named: imageName),
                                            for: UIControlState.normal)
            cell.selectedValue = distanceOption
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func multiSelectTableViewCellButtonTapped(sender: MultiSelectTableViewCell,
                                              selectedValue: String?) {
        let indexPath = filterTableView.indexPath(for: sender)!
        if let filterType: FilterType = FilterType.init(rawValue: indexPath.section) {
            let mds = multiSelectDataSourceByFilterType[filterType]!
            mds.toggleExpanded()
            mds.selectName(name: selectedValue!)
            filterTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filterType = FilterType.init(rawValue: section) {
            switch filterType {
            case .Category:
                return 3
            case .Deal:
                return 1
            case .Distance:
                fallthrough
            case .SortBy:
                let mds = multiSelectDataSourceByFilterType[filterType]!
                return mds.isExpanded ? mds.names.count : 1
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let filterType = FilterType.init(rawValue: section) {
            switch filterType {
            case .Category:
                return "Category"
            case .Deal:
                return nil
            case .Distance:
                return "Distance"
            case .SortBy:
                return "Sort By"
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        let indexPath = filterTableView.indexPath(for: sender)!
        if indexPath.section == FilterType.Deal.rawValue {
            isDeal = value
        } else {
            let rowNum = indexPath.row
            let category = categories[rowNum]
            switchStateByCategory[category["code"]!] = value
        }
    }
    
    func yelpCategories() -> [[String: String]] {
        return [
            ["name": "Asian Fusion", "code": "asianfusion"],
            ["name": "American (New)", "code": "newamerican"],
            ["name": "Italian", "code": "italian"],
            ["name": "Indian", "code": "indpak"],
            ["name": "Afghan", "code": "afghani"],
            ["name": "African", "code": "african"],
            ["name": "Arabian", "code": "arabian"],
            ["name": "Argentine", "code": "argentine"],
            ["name": "Armenian", "code": "armenian"],
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
            ["name": "Irish", "code": "irish"],
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
}
