//
//  TramitesTabBarViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 06/12/22.
//

import UIKit

class TramitesTabBarViewController: UITabBarController {
    
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //sideMenuBtn.target = revealViewController()
        //sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        // Do any additional setup after loading the view.
        self.tabBar.tintColor = UIColor.white // tab bar icon tint color
            self.tabBar.isTranslucent = false
            UITabBar.appearance().barTintColor = UIColor(named: "IISRed")
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
