//
//  CategorySwitchCell.swift
//  Yelp
//
//  Created by bis on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

protocol CategorySwichDelegate: class {
    func categorySwitchvalueChanged(sender: CategorySwitchCell, value: Bool)
}

class CategorySwitchCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    weak var delegate: CategorySwichDelegate?
    
    @IBAction func switchTaped(_ sender: Any) {
        delegate?.categorySwitchvalueChanged(sender: self, value: categorySwitch.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
