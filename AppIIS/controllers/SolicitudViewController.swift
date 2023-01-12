//
//  SolicitudViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 10/01/23.
// https://fluffy.es/scrollview-storyboard-xcode-11/

import UIKit

class SolicitudViewController: UIViewController {
    
    var solicitud: Solicitud?
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfSolicitudLabel: UILabel!
    @IBOutlet var departmentNameLabel: UILabel!
    @IBOutlet var initialsView: UIView!
    @IBOutlet var stepNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print( self.solicitud?.tramiteName)
        self.nameLabel.text = self.solicitud?.tramiteName
        self.numberOfSolicitudLabel.text = "Solicitud #\(solicitud?.tramiteUserNumber ?? "" )"
        self.departmentNameLabel.text = solicitud?.departments
        
        self.stepNumberLabel.text = "\(solicitud?.currentStepNumber ?? 0 )"
        self.initialsView.makeCircleView(50)
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
    
    
    //sudo docker run -dit -e VIRTUAL_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_EMAIL=csanchez@sociales.unam.mx --network=proxy --name test-notificaciones httpd:alpine

}
