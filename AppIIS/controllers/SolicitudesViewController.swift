//
//  TramitesViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class SolicitudesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var solicitudesTable: UITableView!
    @IBOutlet var noSolicitudesLabel: UILabel!
    
    @IBOutlet var viewDecotations: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var solicitudes: [Solicitud] = []
    var solicitudSelected: Solicitud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtonFucntionality(sideMenuBtn)
        //viewDecotations.roundCorners([.topLeft, .topRight], radius: 5)
        //contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        
        self.noSolicitudesLabel.isHidden = true
        setupActivityIndicator()
        //navigationController?.navigationBar.barTintColor = UIColor(named: "IISRed")
        loadData()

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
    
    
    
    
    
    private func setupActivityIndicator(){
         activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
         activityIndicator.center = self.view.center
         self.view.addSubview(activityIndicator)
        
         //activityIndicator.bringSubviewToFront(self.view)
         
     }
     
     
     private func hideActivityIndicator() {
         DispatchQueue.main.async {
             self.activityIndicator.stopAnimating()
             self.activityIndicator.hidesWhenStopped = true
         }
     }
    
    private func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }

    }
    
    private func loadData(){
        showActivityIndicator()
        let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/tramites_users/")!
        
        var request = URLRequest(url: url)
        let defaults = UserDefaults.standard
        let authToken =  defaults.string(forKey: "app_token")
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    self.showAlert(title: "No se puede acceder", message: "Tu sesión ha expirado.")
                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "loggedIn")
                    //self.hideActivityIndicator()
                    self.hideActivityIndicator()
                    return
                }
            }
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                self.showAlert(title: "Error", message: "ocurrio un error desconocido")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                self.showAlert(title: "Error", message: "No hay datos en la respuesta")
                return
            }
            
            do {
                let solicitudesResponse = try JSONDecoder().decode(SolicitudesResponse.self, from: content)
                print(solicitudesResponse.solicitudes[0].tramiteName)
                self.solicitudes = solicitudesResponse.solicitudes
                DispatchQueue.main.async {
                    self.solicitudesTable.reloadData()
                    if(self.solicitudes.isEmpty){
                        self.noSolicitudesLabel.isHidden = false
                        self.solicitudesTable.isHidden = true
                    }else{
                        self.noSolicitudesLabel.isHidden = true
                        self.solicitudesTable.isHidden = false
                    }
                }
                //self.hideActivityIndicator()
                self.hideActivityIndicator()
            } catch let ex {
                self.hideActivityIndicator()
                print(ex)
                self.showAlert(title:"Error", message: "ocurrio un error al procesar la respuesta del servidor")
            }
        }

        task.resume()
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.solicitudes.count
   }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "solicitudCell", for: indexPath) as! SolicitudCell
        let solicitud = self.solicitudes[indexPath.row]
        
        
        /*cell.tramiteNameLabel?.text =  solicitud.tramiteName
        cell.numberOfSolicitudLabel?.text = "Solicitud #\(solicitud.tramiteUserNumber)"
        cell.departmentNameLabel?.text = solicitud.departmentInitial
        cell.makeCircle(solicitud.departmentColor)*/
        
        cell.setSolicitud(solicitud)
        
        
        
       return cell
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.solicitudSelected = self.solicitudes[indexPath.row]
       self.performSegue(withIdentifier: "showSolicitudDetail", sender: Self.self)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! SolicitudViewController
        destination.solicitud = self.solicitudSelected
       }

}
