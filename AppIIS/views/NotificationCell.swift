//
//  NotificationCell.swift
//  AppIIS
//
//  Created by tecnologias on 19/10/22.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    
    @IBOutlet var initialsView: UIView!
    
    @IBOutlet var senderLabel: UILabel!
    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //initialsView.layer.cornerRadius = 15
        //initialsView.layer.masksToBounds = true
        initialsView.makeCircleView(15)
        initialsLabel.text = "ST"
        //initialsLabel.backgroundColor = UIColor.red
        initialsLabel.isEnabled = true
        
        
        //senderLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        
    }
    
    public func makeBoldLabels(){
        self.senderLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        self.dateLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
