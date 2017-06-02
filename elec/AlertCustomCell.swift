//
//  AlertCustomCell.swift
//  elec
//
//  Created by user on 22/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class AlertCustomCell: UITableViewCell {

    @IBOutlet weak var numberimage: UIImageView!
    
    @IBOutlet weak var txtdep: UILabel!
    
    @IBOutlet weak var txtheader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
