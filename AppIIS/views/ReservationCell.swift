//
//  ReservationCell2.swift
//  AppIIS
//
//  Created by Tecnologias iis on 17/11/22.
//

import Foundation
import UIKit

class ReservationCell: UITableViewCell {


    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    @IBOutlet var colorCircleView: UIView!
    
    public func makeCircle(_ colorHex:String){
           //self.colorCircleView.layer.cornerRadius = 13
           //self.colorCircleView.layer.masksToBounds = true
        self.colorCircleView.makeCircleView(13)
           self.colorCircleView.backgroundColor = UIColor.hexStringToUIColor(hex: colorHex)
       }
   }


