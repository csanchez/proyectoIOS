//
//  TramitesViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/01/23.
//

import UIKit

class TramitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var tramitesTable: UITableView!
    @IBOutlet var noTramitesLabel: UILabel!
    @IBOutlet var viewDecoration: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    
    var tramites: [Tramite] = []
    var tramiteSelected: Tramite?
    
    var tipoTramite = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //viewDecoration.roundCorners([.topLeft, .topRight], radius: 5)
        //contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        
        self.noTramitesLabel.isHidden = true
        setupActivityIndicator()
        setBarButtonFucntionality(sideMenuBtn)
        
       
       //NotificationCenter.default.addObserver(self, selector: #selector(loadDataFromNotificationCenter(_:)), name: NSNotification.Name("tipoTramite"), object: nil)
        
        loadData()

        
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
    
    @objc func loadDataFromNotificationCenter(_ notification: Notification) {
        print("loadDataFromNotificationCenter TramitesViewController")
        if let dict =  notification.userInfo as NSDictionary? {
            if let tipoTramite =  dict["tipoTramite"] as? String {
               print(tipoTramite)
            }
        }
        
    }
    
    
    public func setTipoTramite(tipoTramite: String){
        print(tipoTramite)
        self.tipoTramite = tipoTramite
    }
    
    private func loadData(){
        showActivityIndicator()
        
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "notificaciones.sociales.unam.mx"
        components.path = "/api/app/tramites/"
        
        let defaults = UserDefaults.standard
        
        
        
        
        components.queryItems = [
            URLQueryItem(name: "tipoTramite", value: tipoTramite),
            
        ]
        
        
        guard let urlString = components.string else {
            return
        }
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let authToken =  defaults.string(forKey: "app_token")
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")
        
        
        
        /*
         let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/tramites/")!
        
        var request = URLRequest(url: url)
        
        
        
        let authToken =  defaults.string(forKey: "app_token")
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")*/
        
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
                let tramitesResponse = try JSONDecoder().decode(TramitesResponse.self, from: content)
                print(tramitesResponse.tramites[0].name )
                self.tramites = tramitesResponse.tramites
                DispatchQueue.main.async {
                    self.tramitesTable.reloadData()
                    if(self.tramites.isEmpty){
                        self.noTramitesLabel.isHidden = false
                        self.tramitesTable.isHidden = true
                    }else{
                        print("contr amites")
                        self.noTramitesLabel.isHidden = true
                        self.tramitesTable.isHidden = false
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
       return self.tramites.count
   }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tramiteCell", for: indexPath) as! TramiteCell
        let tramite = self.tramites[indexPath.row]
        print(tramite.departments[0].initials)
        cell.tramiteNameLabel?.text =  tramite.name
        cell.departmentNameLabel?.text = tramite.departments[0].initials
        
        let departmentsNames = tramite.departments.map { (department) -> String in
            return department.name
        }
        let departmentsNamesJoined = departmentsNames.joined(separator: ", ")
        
        cell.departmentsListLabel?.text = departmentsNamesJoined
        cell.makeCircle(tramite.departments[0].color)
        return cell
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.tramiteSelected = self.tramites[indexPath.row]
       self.performSegue(withIdentifier: "showTramiteDetail", sender: Self.self)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destination = segue.destination as! TramiteViewController
        destination.tramite = self.tramiteSelected
       }

}
