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
    
    @IBOutlet var statusLabel: UILabel!
    
    
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
    
    
    public func setSolicitud(_ solicitud: Solicitud){
        self.tramiteNameLabel?.text =  solicitud.tramiteName
        self.numberOfSolicitudLabel?.text = "Solicitud #\(solicitud.tramiteUserNumber)"
        self.departmentNameLabel?.text = solicitud.departmentInitial
        self.statusLabel?.text = solicitud.statusName
        
        self.statusLabel.layer.masksToBounds = true
        self.statusLabel.layer.cornerRadius = 5
        self.statusLabel.textColor = .white
        
        switch solicitud.status {
        case 0:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "17a2b8")
        case 1:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "007bff")
        case 2:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "28a745")
        case 3:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "ffc107")
        case 4:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "dc3545")
        default:
            self.statusLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "17a2b8")
        }
        
        self.makeCircle(solicitud.departmentColor)
    }

}
