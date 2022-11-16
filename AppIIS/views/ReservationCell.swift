//
//  ReservationCell.swift
//  AppIIS
//
//  Created by Tecnologias iis on 11/11/22.
//

import UIKit

class ReservationCell: UITableViewCell {
    
    
   
    @IBOutlet var colorCircleView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var spaceLabel: UILabel!
    
    
    public func makeCircle(_ colorHex:String){
        self.colorCircleView.layer.cornerRadius = 13
        self.colorCircleView.layer.masksToBounds = true
        self.colorCircleView.backgroundColor = UIColor.hexStringToUIColor(hex: colorHex)
    }
}

