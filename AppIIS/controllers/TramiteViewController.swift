//
//  TramiteViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 10/01/23.
// https://fluffy.es/scrollview-storyboard-xcode-11/

import UIKit

class TramiteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    var tramite: Tramite?
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var instructionsLabel: UILabel!
    @IBOutlet var viewDecoration: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    
    @IBOutlet var dataTable: UITableView!
    
    
    //@IBOutlet var nuevaSolicitudButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewDecoration.roundCorners([.topLeft, .topRight], radius: 5)
        //contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
       
        
        setBarButtonFucntionality(sideMenuBtn)
        
        
        self.nameLabel.text = self.tramite?.name
        self.descriptionLabel.text = self.tramite?.descripcion
        self.instructionsLabel.text = self.tramite?.instructions
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*@IBAction func nuevaSolicudButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "NuevaSolicitudSegue", sender: Self.self)
    }*/
    
    
    @IBAction func nuevaSolicudButtonClick2(_ sender: Any) {
        self.performSegue(withIdentifier: "NuevaSolicitudSegue", sender: Self.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! NuevaSolicitudViewController
        destination.tramite = self.tramite
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tramite?.data.count ?? 0
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tramiteDataCell", for: indexPath) as! TramiteDataCell
        
         
        let data = self.tramite?.data [indexPath.row]
        
        
         
         /*cell.instructionsLabel?.text =  condition.instruction
         cell.statusLabel?.text =  condition.iisRole*/
        cell.dataName?.text = data?.name
         

         
         
        // cell.makeCircle(solicitud.departmentColor)
        return cell
    }
    
    
    
    
    
    
}
