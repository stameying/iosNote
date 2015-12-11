//
//  Next7DayTableViewCell.swift
//  forecast
//
//  Created by xiaoran.hu on 11/16/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class Next7DayTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var lowhighLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
