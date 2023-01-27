//
//  UINavigationController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 27/01/23.
//

import Foundation
import UIKit

@IBDesignable extension UINavigationController {
    @IBInspectable var barTintColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.barTintColor = uiColor
        }
        get {
            guard let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
}
