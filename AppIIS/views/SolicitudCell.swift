//
//  SolicitudCell.swift
//  AppIIS
//
//  Created by Tecnologias iis on 06/12/22.
//

import UIKit

class SolicitudCell: UITableViewCell {
    
    @IBOutlet var tramiteNameLabel: UILabel!
    @IBOutlet var departmentNameLabel: UILabel!
    
    @IBOutlet var numberOfSolicitudLabel: UILabel!
    
    
    
    @IBOutlet var colorCircleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func makeCircle(_ colorHex:String){
           //self.colorCircleView.layer.cornerRadius = 5
           //self.colorCircleView.layer.masksToBounds = true
        self.colorCircleView.makeCircleView(15)
           self.colorCircleView.backgroundColor = UIColor.hexStringToUIColor(hex: colorHex)
    }

}
