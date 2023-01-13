//
//  DataCell.swift
//  AppIIS
//
//  Created by Tecnologias iis on 13/01/23.
//

import UIKit

class DataCell: UITableViewCell {
    
    
    
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
