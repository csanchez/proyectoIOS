//
//  LaunchViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 24/11/22.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gradienteLayer = CAGradientLayer()
        gradienteLayer.frame = view.bounds
        gradienteLayer.colors = [
            UIColor.systemRed.cgColor,
            UIColor.systemBlue
        ]
        view.layer.addSublayer(gradienteLayer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
