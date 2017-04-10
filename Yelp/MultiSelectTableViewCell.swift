//
//  MultiSelectTableViewCell.swift
//  Yelp
//
//  Created by bis on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit


protocol MultiSelectTableViewCellDelegate: class {
    func multiSelectTableViewCellButtonTapped(sender: MultiSelectTableViewCell,
                                              selectedValue: String?)
}


class MultiSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var selectStateButton: UIButton!
    
    var selectedValue: String? = nil
    var delegate: MultiSelectTableViewCellDelegate?
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.multiSelectTableViewCellButtonTapped(
            sender: self, selectedValue: selectedValue)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
