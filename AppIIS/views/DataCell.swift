//
//  DataCell.swift
//  AppIIS
//
//  Created by Tecnologias iis on 13/01/23.
//

import UIKit

class DataCell: UITableViewCell {
    
    
    
    @IBOutlet var instructionsLabel: UILabel!
   
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCondition(_ condition: Condition){
        self.instructionsLabel.text = condition.instruction
        
        
        if(condition.completed){
            self.statusLabel.text = condition.completedAt
            self.statusImage.image = UIImage(systemName: "checkmark.seal.fill")?.withRenderingMode(.alwaysTemplate)
            self.statusImage.tintColor = UIColor.hexStringToUIColor(hex: "28a745")
        }else{
            self.statusLabel.text = condition.iisRole
            self.statusImage.image = UIImage(systemName: "xmark.seal.fill")?.withRenderingMode(.alwaysTemplate)
            self.statusImage.tintColor = UIColor.hexStringToUIColor(hex: "dc3545")
        }
        
        
    }
    
    

}
