//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by bis on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var business: Business? {
        didSet {
            ratingImageView.setImageWith((business?.ratingImageURL!)!)
            thumbImage.setImageWith((business?.imageURL!)!)
            addressLabel.text = business?.address!
            reviewsLabel.text = "\(business?.reviewCount! ?? 0) Reviews"
            nameLabel.text = business?.name
        }
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
