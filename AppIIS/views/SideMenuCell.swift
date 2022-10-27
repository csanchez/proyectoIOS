//
//  SideMenuCell.swift
//  AppIIS
//
//  Created by tecnologias on 27/10/22.
//

import Foundation
import UIKit

class SideMenuCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    @IBOutlet var menuLabel: UILabel!
    
    @IBOutlet var menuIcon: UIImageView!
    
    
    //@IBOutlet var iconImageView: UIImageView!
    //@IBOutlet var titleLabel: UILabel!
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        self.backgroundColor = .clear
        
        // Icon
        self.iconImageView.tintColor = .white
        
        // Title
        self.titleLabel.textColor = .white
    }*/
}
