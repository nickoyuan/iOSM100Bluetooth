//
//  HarnessTableViewCell.swift
//  elec
//
//  Created by user on 28/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class HarnessTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txttitle: UILabel!
    
    @IBOutlet weak var imgnum: UIImageView!
    
    @IBOutlet weak var txtdesc: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
