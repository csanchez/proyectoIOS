//
//  StartViewController.swift
//  AppIIS
//
//  Created by tecnologias on 11/10/22.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet var backgroundGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradienteBackground(backgroundGradientView)
        
        // add these lines
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // if user is logged in before
        
        print("en start")
        
        //UserDefaults.standard.removeObject(forKey: "loggedIn")
        /*if UserDefaults.standard.string(forKey: "loggedIn") != nil {
                // instantiate the main tab bar controller and set it as root view controller
                // using the storyboard identifier we set earlier
                //let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainController")
                //window?.rootViewController = mainTabBarController
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } else {
                // if user isn't logged in
                // instantiate the navigation controller and set it as root view controller
                // using the storyboard identifier we set earlier
                let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
                //window?.rootViewController = loginNavController
        }*/
        // Do any additional setup after loading the view.
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
