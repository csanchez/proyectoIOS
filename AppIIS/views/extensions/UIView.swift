//
//  UIView.swift
//  AppIIS
//
//  Created by Tecnologias iis on 22/11/22.
//

import Foundation
import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: 1, height: 1)
            self.layer.shadowOpacity = 1
    }
    
    func makeCircleView(_ radius: CGFloat){
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
    }

}
