//
//  TramitesNavigationController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 27/01/23.
//

import UIKit

class TramitesPersonalesNavigationController: UINavigationController {

    public let tipoTramite = "personal"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc =  self.viewControllers.first as! TramitesViewController
        vc.setTipoTramite(tipoTramite: tipoTramite)
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
