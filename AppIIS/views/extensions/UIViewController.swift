//
//  UIViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 28/11/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func setGradienteBackground(_ backgroundGradientView : UIView){
        
        // https://techion.com.au/blog/2018/11/14/creating-gradient-backgrounds-in-swift
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        //gradientLayer.colors = [#colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor, UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1).cgColor]
        gradientLayer.colors = [UIColor(named: "IISBlack")!.cgColor,  UIColor(named: "IISRed")!.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        backgroundGradientView.layer.addSublayer(gradientLayer)
    }
    
    
    
    /*func setupActivityIndicator(_ activityIndicator: UIActivityIndicatorView,_ parent: UIView){
        activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        //activityIndicator.startAnimating()
    }
    
    
     func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }

    }
     func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        }

    }*/
}

