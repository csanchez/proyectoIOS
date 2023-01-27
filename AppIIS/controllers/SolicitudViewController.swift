//
//  SolicitudViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 10/01/23.
// https://fluffy.es/scrollview-storyboard-xcode-11/

import UIKit

class SolicitudViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var solicitud: Solicitud?
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfSolicitudLabel: UILabel!
    @IBOutlet var departmentNameLabel: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var initialsView: UIView!
    
    @IBOutlet var stepNumberLabel: UILabel!
    
    @IBOutlet var dataTable: UITableView!
    @IBOutlet var stepName: UILabel!
    //@IBOutlet var stepStatus: UILabel!
    
    @IBOutlet var stepDescription: UILabel!
    
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var viewDecotations: UIView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtonFucntionality(sideMenuBtn)
        //viewDecotations.roundCorners([.topLeft, .topRight], radius: 5)
        //contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        
        //print( self.solicitud?.tramiteName)
        self.nameLabel.text = self.solicitud?.tramiteName
        self.numberOfSolicitudLabel.text = "Solicitud #\(solicitud?.tramiteUserNumber ?? "" )"
        self.departmentNameLabel.text = solicitud?.departments
        self.statusLabel.text = solicitud?.statusName
        
        self.statusLabel.layer.masksToBounds = true
        self.statusLabel.layer.cornerRadius = 5
        self.statusLabel.textColor = .white
        
        
        switch solicitud?.status {
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
        
        
        
        
        
        
        
        //self.stepNumberLabel.text = "\(solicitud?.currentStepNumber ?? 0 )"
        
        self.stepNumberLabel.text = "\(solicitud?.currentStepNumber ?? "" ) / \(solicitud?.totalSteps ?? "" )"
        self.stepNumberLabel.textColor = .white
        self.stepName.text = solicitud?.currentStep.name
        
        self.stepDescription.text = solicitud?.currentStep.descripcion
        self.initialsView.makeCircleView(25)
        self.initialsView.backgroundColor = UIColor.hexStringToUIColor(hex: "A52E42")
        
        //self.stepStatus.text = solicitud?.currentStep.state
        //self.stepStatus.textColor = .white
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.solicitud?.currentStep.conditions.count ?? 0
   }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! SolicitudDataCell
        let condition = self.solicitud!.currentStep.conditions[indexPath.row]
        
       
        
        /*cell.instructionsLabel?.text =  condition.instruction
        cell.statusLabel?.text =  condition.iisRole*/
        cell.setCondition(condition)
        

        
        
       // cell.makeCircle(solicitud.departmentColor)
       return cell
   }
   
   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.solicitudSelected = self.solicitudes[indexPath.row]
       self.performSegue(withIdentifier: "showSolicitudDetail", sender: Self.self)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! SolicitudViewController
        destination.solicitud = self.solicitudSelected
       }*/
    
    
    //sudo docker run -dit -e VIRTUAL_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_EMAIL=csanchez@sociales.unam.mx --network=proxy --name test-notificaciones httpd:alpine

}
