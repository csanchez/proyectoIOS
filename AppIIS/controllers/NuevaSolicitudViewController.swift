//
//  NuevaSolicitudViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 27/01/23.
//

import UIKit

class NuevaSolicitudViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    var tramite: Tramite?
    
    @IBOutlet var dataTable: UITableView!
    @IBOutlet var tramiteName: UILabel!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    var activityIndicator = UIActivityIndicatorView()
    
    
    var viewHeight = 0.0
    var solicitudCreated: Solicitud?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtonFucntionality(sideMenuBtn)
        setupActivityIndicator()
        
        self.tramiteName.text = tramite?.name
        
        viewHeight = self.view.frame.size.height
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(NuevaSolicitudViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(NuevaSolicitudViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
        return self.tramite?.data.count ?? 0
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newDataCell", for: indexPath) as! NewSolicitudDataCell
        
         
        let data = self.tramite?.data [indexPath.row]
        
        
         
         /*cell.instructionsLabel?.text =  condition.instruction
         cell.statusLabel?.text =  condition.iisRole*/
        cell.dataName?.text = data?.name
         

         
         
        // cell.makeCircle(solicitud.departmentColor)
        return cell
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
        self.view.frame.size.height = (viewHeight - keyboardSize.height)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.size.height = viewHeight
    }
    
    
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
    
    
    
    @IBAction func registerNewSolicitud(_ sender: Any) {
        
        let data = self.tramite?.data
        
     
        
        let cells = self.dataTable.visibleCells as! Array<NewSolicitudDataCell>
        
        for (index, cell) in cells.enumerated() {
            data![index].value = cell.dataValue.text ?? ""
            let d =  ["value": cell.dataValue.text ?? "","label": data![index].label,"name": data![index].name ]
        }
        
        
        showActivityIndicator()
        
        do {
            
            
            
            
            let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/tramites_users/")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \( UserDefaults.standard.string(forKey: "app_token")!)", forHTTPHeaderField: "Authorization")
            
            
            
            
            let nuevaSolicitud = NuevaSolicitud(tramite: TramiteNuevaSolicitud(id:  self.tramite?.slug ?? "" , data: data ??  [] ) )
            
            
            let jsonEncoder = JSONEncoder()
            guard let postData = try?jsonEncoder.encode(nuevaSolicitud) else {
                return
            }
            
            request.httpBody = postData
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 401 {
                        self.showAlert(title: "No se puede acceder", message: "Tu sesión ha expirado.")
                        let defaults = UserDefaults.standard
                        defaults.set(false, forKey: "loggedIn")
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
                    let nuevaSolicitudResponse = try JSONDecoder().decode(NuevaSolicitudResponse.self, from: content)
                    print(nuevaSolicitudResponse.message)
                    self.solicitudCreated = nuevaSolicitudResponse.solicitud
                    
                    
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showSolicitudDetail2", sender: Self.self)
                    }
                    //self.hideActivityIndicator()
                    self.hideActivityIndicator()
                } catch let ex {
                    self.hideActivityIndicator()
                    print(ex)
                    self.showAlert(title:"Error", message: "ocurrio un error al procesar la respuesta del servidor")
                }
                
                
                
                
                
                
            }
            
            //self.view.makeToast("This is a piece of toast")
            // execute the HTTP request
            task.resume()
            
        }
    }
        
        
        private func showAlertAndEnableView(title:String, message:String){
            DispatchQueue.main.async {
                self.showAlert(title:title, message: message);
                
                self.hideActivityIndicator()
            }
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        
        //let navigation = segue.destination as! UINavigationController
        let destination = segue.destination as! SolicitudViewController
        //let destination = navigation.viewControllers [0] as! SolicitudViewController
               
        destination.solicitud = self.solicitudCreated
        destination.senderParent = 1
    }
    
    
    
    
    
    
    

}
