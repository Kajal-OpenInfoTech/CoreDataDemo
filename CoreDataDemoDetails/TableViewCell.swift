//
//  TableViewCell.swift
//  CoreDataDemoDetails
//
//  Created by Mac 1 on 3/23/18.
//  Copyright © 2018 OpenInfoTech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var txtName: UILabel!
    
    @IBOutlet var txtEmail: UILabel!
    
    @IBOutlet var txtMobileNumber: UILabel!
    
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
