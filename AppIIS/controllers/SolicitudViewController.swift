//
//  SolicitudViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 10/01/23.
// https://fluffy.es/scrollview-storyboard-xcode-11/

import UIKit

class SolicitudViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var solicitud: Solicitud?
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberOfSolicitudLabel: UILabel!
    @IBOutlet var departmentNameLabel: UILabel!
    @IBOutlet var initialsView: UIView!
    @IBOutlet var stepNumberLabel: UILabel!
    
    @IBOutlet var dataTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print( self.solicitud?.tramiteName)
        self.nameLabel.text = self.solicitud?.tramiteName
        self.numberOfSolicitudLabel.text = "Solicitud #\(solicitud?.tramiteUserNumber ?? "" )"
        self.departmentNameLabel.text = solicitud?.departments
        
        print(solicitud!)
        
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
    

    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.solicitud?.da
   }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "solicitudCell", for: indexPath) as! SolicitudCell
        let solicitud = self.solicitudes[indexPath.row]
        cell.tramiteNameLabel?.text =  solicitud.tramiteName
        
        
        cell.numberOfSolicitudLabel?.text = "Solicitud #\(solicitud.tramiteUserNumber)"
        cell.departmentNameLabel?.text = solicitud.departmentInitial
        cell.makeCircle(solicitud.departmentColor)
       return cell
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.solicitudSelected = self.solicitudes[indexPath.row]
       self.performSegue(withIdentifier: "showSolicitudDetail", sender: Self.self)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! SolicitudViewController
        destination.solicitud = self.solicitudSelected
       }*/
    
    
    //sudo docker run -dit -e VIRTUAL_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_HOST=notificaciones.sociales.unam.mx -e LETSENCRYPT_EMAIL=csanchez@sociales.unam.mx --network=proxy --name test-notificaciones httpd:alpine

}
