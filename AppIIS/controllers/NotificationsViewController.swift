//
//  NotificationsTableViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {// UITableViewController {
    
    
    
    
    //@IBOutlet var notificationTable: UITableView!
    
    @IBOutlet var notificationTable: UITableView!
    
    @IBOutlet var noNotificacionesLabel: UILabel!
    
    var activityIndicator = UIActivityIndicatorView()
    var notifications: [IisNotification] = []
    var notificationSelected: IisNotification?
    
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet var viewDecoration: UIView!
    @IBOutlet var contentView: UIView!
    
    //@IBOutlet var activityIndicator: UIActivityIndicatorView!
    //@IBOutlet var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDecoration.roundCorners([.topLeft, .topRight], radius: 5)
        contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        
        self.noNotificacionesLabel.isHidden = true
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        setupActivityIndicator()
        loadData()
    }

    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }

    }
    
    private func setupActivityIndicator(){
        activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
    }
    
    private func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }

    }
    
    /*private func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.loadingView.isHidden = true
        })
        
    }*/
    
    
    //private func loadData(handler: @escaping (Result<[NotificationsResponse],Error>) -> Void){
    //func loadData(handler: @escaping Handler<NotificationsResponse>) {
    private func loadData(){
        showActivityIndicator()
        let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/notifications/")!
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
                let notificationsResponse = try JSONDecoder().decode(NotificationsResponse.self, from: content)
                self.notifications = notificationsResponse.notifications
                DispatchQueue.main.async {
                    self.notificationTable.reloadData()
                    if(self.notifications.isEmpty){
                        self.noNotificacionesLabel.isHidden = false
                        self.notificationTable.isHidden = true
                    }else{
                        self.noNotificacionesLabel.isHidden = true
                        self.notificationTable.isHidden = false
                    }
                }
                //self.hideActivityIndicator()
                self.hideActivityIndicator()
            } catch _ {
                self.hideActivityIndicator()
                self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
            }
        }

        task.resume()
        
    }
    
   
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        cell.initialsLabel?.text = self.notifications[indexPath.row].originInitials
        cell.senderLabel?.text = self.notifications[indexPath.row].sender
        cell.titleLabel?.text = self.notifications[indexPath.row].title
        cell.dateLabel?.text = self.notifications[indexPath.row].createdAt
        
        if self.notifications[indexPath.row].status == "unseen"{
            cell.makeBoldLabels()
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.notificationSelected = self.notifications[indexPath.row]
        self.performSegue(withIdentifier: "showNotificationDetail", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NotificationViewController
        
        destination.notification = self.notificationSelected
        
        let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/mark-as-seen")!
        var request = URLRequest(url: url)
        let defaults = UserDefaults.standard
        let authToken =  defaults.string(forKey: "app_token")
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")

        let params = ["id": self.notificationSelected?.userNotificationId] //as Dictionary<String, String>

        guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        

        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                //self.showAlertAndEnableView(title: "Error", message: "ocurrio un error desconocido")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard data != nil else {
                print("No data")
                //throw AppError.customError(message: "No hay datos en la respuesta")
                /*DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "No hay datos en la respuesta");
                    self.loginButton.isEnabled = true
                }*/
               // self.showAlertAndEnableView(title: "Error", message: "No hay datos en la respuesta")
                return
            }
            
            
            
            // serialise the data / NSData object into Dictionary [String : Any]
           /*guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
               /* DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "ocurrio un error al procesar la respuesta del servidor");
                    self.loginButton.isEnabled = true
                }*/
              // self.showAlertAndEnableView(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
                //throw AppError.invalidJsonResponse
                return
            }*/
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("status",httpResponse.statusCode)
                if httpResponse.statusCode == 401 {
                    /*DispatchQueue.main.async {
                        self.showAlert(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida");
                        self.loginButton.isEnabled = true
                    }*/
                    //self.showAlertAndEnableView(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida")
                    //throw AppError.invalidUserOrPassword
                    return
                }
                if httpResponse.statusCode == 200 {
                    self.notificationSelected?.status = "seen"
                }
                    
            }
            
            
            
            self.hideActivityIndicator()
            
           
        }
        
    
        task.resume()
        
    }
    
    
    /*@IBAction func revealSideMenu(_ sender: Any) {
        //self.sideMenuState(expanded: self.isExpanded ? false : true)
    }*/
    
    

}
