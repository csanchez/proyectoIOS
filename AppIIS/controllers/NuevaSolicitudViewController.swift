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
        
        var data =   self.tramite?.data
        
        let cells = self.dataTable.visibleCells as! Array<NewSolicitudDataCell>

        for (index, cell) in cells.enumerated() {
            
            data![index].value = cell.dataValue.text ?? ""
            
        }
        
        print(data![0].value)
        print(data![1].value)
        print(data![2].value)
        
        /*showActivityIndicator()
        
        do {
                
            let defaults = UserDefaults.standard
            
            
            let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/tramites_users/")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \( UserDefaults.standard.string(forKey: "app_token")!)", forHTTPHeaderField: "Authorization")
            
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self.tramite.)
            let json = String(data: jsonData, encoding: String.Encoding.utf16)
            

            let params = ["tramite": ["d":self.tramite?.slug, "data":password] ] //as Dictionary<String, String>

            guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            


            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // ensure there is no error for this HTTP response
                guard error == nil else {
                    print ("error: \(error!)")
                    //throw AppError.customError(message: "Ocurrio un error indesperado")
                   
                    self.showAlertAndEnableView(title: "Error", message: "ocurrio un error desconocido")
                    return
                }
                
                // ensure there is data returned from this HTTP response
                guard let content = data else {
                    print("No data")
                    //throw AppError.customError(message: "No hay datos en la respuesta")
                    
                    self.showAlertAndEnableView(title: "Error", message: "No hay datos en la respuesta")
                    return
                }
                
                
                
                // serialise the data / NSData object into Dictionary [String : Any]
               guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                   
                   self.showAlertAndEnableView(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
                    //throw AppError.invalidJsonResponse
                    return
                }
                
                print("gotten json response dictionary is \n \(json)")
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    print("status",httpResponse.statusCode)
                    if httpResponse.statusCode == 401 {
                        
                        self.showAlertAndEnableView(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida")
                        //throw AppError.invalidUserOrPassword
                        return
                    }
                        
                }
                
                let user = json["user"] as? [String:Any]
                
                let appToken =  user?["app_token"]
                let email =  user?["email"]
                let firstName =  user?["first_name"]
                //let firstName =  user?["iis_role"]
                let lastName =  user?["last_name"]
                let picture =  user?["picture_url"]
                let rfc =  user?["rfc"]
                let userType =  user?["user_type"]
                
                
                defaults.set(true, forKey: "loggedIn")
                defaults.set(appToken!, forKey: "app_token")
                defaults.set(email!, forKey: "email")
                defaults.set(firstName!, forKey: "first_name")
                //defaults.set( forKey: "iis_role")
                defaults.set(lastName!, forKey: "last_name")
                defaults.set(picture!, forKey: "picture_url")
                defaults.set(rfc!, forKey: "rfc")
                defaults.set(userType!, forKey: "user_type")
                
                DispatchQueue.main.async {
                   // self.loginButton.isEnabled = true
                    self.hideSpinner()
                    //self.performSegue(withIdentifier: "loginToMainSegue", sender: Self.self)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
                
               
            }
            
            //self.view.makeToast("This is a piece of toast")
            // execute the HTTP request
            task.resume()*/
        
        
        
        
    }
    
    
    

}
