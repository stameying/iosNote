//
//  Next24HourTableViewCell.swift
//  forecast
//
//  Created by xiaoran.hu on 11/16/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class Next24HourTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
