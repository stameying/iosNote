//
//  stateDetailTableViewCell.swift
//  forecast
//
//  Created by xiaoran.hu on 11/12/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit


class stateDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stateName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
